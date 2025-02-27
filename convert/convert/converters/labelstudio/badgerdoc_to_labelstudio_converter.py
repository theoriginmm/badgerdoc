import tempfile
from pathlib import Path
from typing import Any, Dict, List, NamedTuple, Optional

import requests
from botocore.client import BaseClient
from fastapi import HTTPException, status
from tenant_dependency import TenantData

from convert.config import settings
from convert.converters.base_format.models import annotation_practic
from convert.converters.base_format.models.annotation import (
    BadgerdocAnnotation,
)
from convert.converters.base_format.models.manifest import Manifest
from convert.converters.base_format.models.tokens import BadgerdocToken, Page
from convert.converters.labelstudio.annotation_converter_practic import (
    AnnotationConverterToTheory,
)
from convert.logger import get_logger
from convert.models.common import S3Path

from .models.annotation import (
    Annotation,
    Data,
    DocumentRelation,
    LabelStudioModel,
    Meta,
    ModelItem,
    ResultItem,
    Value,
)

LOGGER = get_logger(__file__)
LOGGER.setLevel("DEBUG")


class BadgerdocData(NamedTuple):
    page: Page
    annotation: BadgerdocAnnotation
    manifest: Manifest


class BadgerdocToLabelstudioConverter:
    LABELSTUDIO_FILENAME = "ls_format.json"

    def __init__(
        self,
        s3_client: BaseClient,
        current_tenant: str,
        token_data: TenantData,
    ) -> None:
        self.s3_client = s3_client
        self.current_tenant = current_tenant
        self.token_data = token_data
        self.request_headers = {
            "X-Current-Tenant": self.current_tenant,
            "Authorization": f"Bearer {self.token_data.token}",
        }
        self.ls_format = LabelStudioFormat()

    def execute(
        self,
        s3_input_tokens: S3Path,
        s3_input_annotations: S3Path,
        s3_input_manifest: S3Path,
        s3_output_annotation: S3Path,
    ) -> None:
        (
            badgerdoc_page,
            badgerdoc_annotations,
            badgerdoc_manifest,
        ) = self.download(
            s3_input_tokens, s3_input_annotations, s3_input_manifest
        )
        self.ls_format.from_badgerdoc(
            badgerdoc_page,
            badgerdoc_annotations,
            badgerdoc_manifest,
            self.request_headers,
        )
        self.upload(s3_output_annotation)

    def download(
        self,
        s3_input_tokens: S3Path,
        s3_input_annotations: S3Path,
        s3_input_manifest: S3Path,
    ) -> BadgerdocData:
        with tempfile.TemporaryDirectory() as tmp_dirname:
            tmp_dir = Path(tmp_dirname)

            input_tokens = self.download_file_from_s3(s3_input_tokens, tmp_dir)
            input_annotations = self.download_file_from_s3(
                s3_input_annotations, tmp_dir
            )
            input_manifest = self.download_file_from_s3(
                s3_input_manifest, tmp_dir
            )
            LOGGER.debug("input_manifest: %s", input_manifest.read_text())

            page = Page.parse_file(input_tokens)
            annotation = AnnotationConverterToTheory(
                practic_annotations=annotation_practic.BadgerdocAnnotation.parse_file(  # noqa
                    input_annotations
                )
            ).convert()
            manifest = Manifest.parse_file(input_manifest)
            return BadgerdocData(
                page=page, annotation=annotation, manifest=manifest
            )

    def download_file_from_s3(self, s3_path: S3Path, tmp_dir: Path) -> Path:
        local_file_path = tmp_dir / Path(s3_path.path).name
        self.s3_client.download_file(
            s3_path.bucket,
            s3_path.path,
            str(local_file_path),
        )
        return local_file_path

    def upload(
        self,
        s3_output_annotation: S3Path,
    ) -> None:
        with tempfile.TemporaryDirectory() as tmp_dirname:
            tmp_dir = Path(tmp_dirname)

            badgerdoc_annotations_path = tmp_dir / Path(
                self.LABELSTUDIO_FILENAME
            )
            self.ls_format.export_json(badgerdoc_annotations_path)
            self.s3_client.upload_file(
                str(badgerdoc_annotations_path),
                s3_output_annotation.bucket,
                s3_output_annotation.path,
            )


class LabelStudioFormat:
    DEFAULT_ID_FOR_ONE_ANNOTATION = 1
    # TODO: support more than 1 page

    def __init__(self) -> None:
        self.labelstudio_data = LabelStudioModel()

    @staticmethod
    def form_token_text(token: BadgerdocToken) -> str:
        text = f"{token.previous or ''}{token.text}{token.after or ''}"
        return text

    def from_badgerdoc(
        self,
        badgerdoc_tokens: Page,
        badgerdoc_annotations: BadgerdocAnnotation,
        badgerdoc_manifest: Optional[Manifest],
        request_headers: Dict[str, str],
    ):
        text = "".join(
            [self.form_token_text(obj) for obj in badgerdoc_tokens.objs]
        )

        objs = self.convert_annotation_from_bd(
            badgerdoc_annotations, badgerdoc_tokens.objs
        )
        relations = self.convert_relation_from_bd(badgerdoc_annotations)
        document_links = (
            self.convert_document_links_from_bd(badgerdoc_manifest)
            if badgerdoc_manifest
            else []
        )
        document_labels = [
            {
                "id": document_label["value"],
                "name": document_label["value"],
                "parent": None,
            }
            for document_label in badgerdoc_manifest.categories
        ]
        job_id = badgerdoc_manifest.job_id
        categories_linked_with_taxonomies = (
            self.get_categories_linked_with_taxonomies(job_id, request_headers)
        )
        LOGGER.debug(
            "Got there categories linked to taxonomies: %s",
            categories_linked_with_taxonomies,
        )

        categories_to_taxonomy_mapping = self.create_categories_to_taxonomy_mapping(  # noqa
            job_id=job_id,
            categories_linked_with_taxonomies=categories_linked_with_taxonomies,  # noqa
            request_headers=request_headers,
        )
        annotation = Annotation(
            id=self.DEFAULT_ID_FOR_ONE_ANNOTATION, result=objs + relations
        )

        item = ModelItem(
            annotations=[annotation],
            predictions=[],
            data=Data(text=text),
            meta=Meta(
                labels=document_labels,
                relations=document_links,
                categories_to_taxonomy_mapping=categories_to_taxonomy_mapping,
            ),
        )

        self.labelstudio_data.__root__.append(item)

    @classmethod
    def convert_annotation_from_bd(
        cls, annotations: BadgerdocAnnotation, tokens: List[BadgerdocToken]
    ) -> List[ResultItem]:
        objs = annotations.pages[0].objs
        result_items = []
        for obj in objs:
            if not obj.tokens:
                continue
            item = ResultItem(
                id=obj.id,
                from_name="label",
                to_name="text",
                type="labels",
                origin="manual",
                value=Value(
                    start=min(obj.tokens),
                    end=max(obj.tokens) + 1,
                    text="".join(
                        cls.form_token_text(tokens[index])
                        for index in obj.tokens
                    ),
                    labels=[obj.category],
                ),
            )
            if obj.data.dataAttributes:
                item.value.taxons = [
                    obj.data.dataAttributes[0]["value"],
                ]
            else:
                item.value.taxons = [
                    None,
                ]

            result_items.append(item)
        return result_items

    def convert_relation_from_bd(
        self, annotations: BadgerdocAnnotation
    ) -> List[ResultItem]:
        objs = annotations.pages[0].objs
        result_items = []
        for obj in objs:
            if not obj.links:
                continue
            for link in obj.links:
                item = ResultItem(
                    from_id=obj.id,
                    to_id=link.to,
                    type="relation",
                    direction=self.form_link_direction(),
                    labels=[link.category_id],
                )
                result_items.append(item)
        return result_items

    @staticmethod
    def convert_document_links_from_bd(
        manifest: Manifest,
    ) -> List[DocumentRelation]:
        return [
            # converting from a model with same attributes
            DocumentRelation(**document_link.dict())
            for document_link in manifest.links_json
        ]

    @staticmethod
    def form_link_direction() -> str:
        # TODO: add logic for transformation link from badgerdoc format
        return "right"

    def export_json(self, path: Path):
        path.write_text(self.labelstudio_data.json())

    @staticmethod
    def get_categories_linked_with_taxonomies(
        job_id: int, request_headers: Dict[str, str]
    ) -> List[str]:
        annotations_get_categories_url = (
            f"{settings.annotation_service_url}jobs/{job_id}/categories/search"
        )
        annotations_get_categories_body = {
            "pagination": {"page_num": 1, "page_size": 100}
        }
        LOGGER.debug(
            "Making request to url %s to get all categories for job_id %s",
            annotations_get_categories_url,
            job_id,
        )

        try:
            request_to_get_categories = requests.post(
                url=annotations_get_categories_url,
                headers=request_headers,
                json=annotations_get_categories_body,
            )
            request_to_get_categories.raise_for_status()
        except requests.exceptions.RequestException as exception:
            LOGGER.exception(
                "Failed request to 'annotation' to get "
                "all categories for specific job"
            )
            raise HTTPException(
                status_code=status.HTTP_422_UNPROCESSABLE_ENTITY,
                detail="Failed request to 'annotation' to get "
                "all categories for specific job",
            ) from exception

        LOGGER.debug(
            "Got this response from annotation service: %s",
            request_to_get_categories.json(),
        )
        all_categories_got = request_to_get_categories.json()["data"]
        categories_linked_with_taxonomies = [
            category["id"]
            for category in all_categories_got
            if category["data_attributes"]
        ]
        return categories_linked_with_taxonomies

    @staticmethod
    def get_corresponding_taxonomy_obj(
        job_id: int, category_id: str, request_headers: Dict[str, str]
    ) -> List[Dict[str, str]]:
        get_taxonomy_url = (
            f"{settings.taxonomy_service_url}taxonomy/"
            f"link_category/{job_id}/{category_id}"
        )
        LOGGER.debug(
            "Making request to url %s to get corresponding taxonomy",
            get_taxonomy_url,
        )

        try:
            request_to_get_taxonomy = requests.get(
                url=get_taxonomy_url,
                headers=request_headers,
            )
            request_to_get_taxonomy.raise_for_status()
        except requests.exceptions.RequestException as exception:
            LOGGER.exception(
                "Failed request to 'taxonomy' to get corresponding taxonomy"
            )
            raise HTTPException(
                status_code=status.HTTP_422_UNPROCESSABLE_ENTITY,
                detail="Failed request to 'taxonomy' to "
                "get corresponding taxonomy",
            ) from exception
        response_content = request_to_get_taxonomy.json()
        LOGGER.debug(
            "Got this response from taxonomy service: %s", response_content
        )

        return [
            {"taxonomy_id": element["id"], "version": element["version"]}
            for element in response_content
        ]

    def create_categories_to_taxonomy_mapping(
        self, job_id, categories_linked_with_taxonomies, request_headers
    ):
        result = {}
        for category_id in categories_linked_with_taxonomies:
            taxonomy_objs = self.get_corresponding_taxonomy_obj(
                job_id=job_id,
                category_id=category_id,
                request_headers=request_headers,
            )
            for taxonomy_obj in taxonomy_objs:
                result.update({category_id: taxonomy_obj})
        return result

    @staticmethod
    def get_taxonomy_to_taxons_mapping(
        all_taxonomies_ids_used: List[str],
        request_headers: Dict[str, str],
    ) -> Dict[str, Any]:
        get_taxons_used_url = f"{settings.taxonomy_service_url}taxons/search"
        LOGGER.debug(
            "Making request to url %s to get all taxons used",
            get_taxons_used_url,
        )
        get_taxons_used_body = {
            "pagination": {"page_num": 1, "page_size": 100},
            "filters": [
                {
                    "field": "taxonomy_id",
                    "operator": "in",
                    "value": all_taxonomies_ids_used,
                }
            ],
        }

        try:
            request_to_get_taxons_used = requests.post(
                url=get_taxons_used_url,
                json=get_taxons_used_body,
                headers=request_headers,
            )
            request_to_get_taxons_used.raise_for_status()
        except requests.exceptions.RequestException as exception:
            LOGGER.exception("Failed request to 'taxonomy' to get taxons_used")
            raise HTTPException(
                status_code=status.HTTP_422_UNPROCESSABLE_ENTITY,
                detail="Failed request to 'taxonomy' to get taxons_used",
            ) from exception
        response_content = request_to_get_taxons_used.json()
        LOGGER.debug(
            "Got this response from taxonomy service: %s", response_content
        )

        result = {taxonomy_id: [] for taxonomy_id in all_taxonomies_ids_used}
        for taxon_obj in response_content["data"]:
            taxonomy_id_of_taxon = taxon_obj["taxonomy_id"]
            result[taxonomy_id_of_taxon].append(taxon_obj["id"])

        return result
