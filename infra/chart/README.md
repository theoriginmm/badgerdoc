# How to install minimal badgedoc app

## Prerequisites

1. PostgreSQL database host, port, credentials per service
2. Access to S3

## How to install

set values in values.yaml

run in shell
```shell
helm install --debug --dry-run badgerdoc .
```

### Configuration of values

| Parameter                          | Description        | Default                                          |
|------------------------------------|--------------------|--------------------------------------------------|
| `global.db.host`                   |                    | `postgres`                                       |
| `global.db.port`                   |                    | `5432`                                           |
| `global.s3.endpoint`               |                    | `http://minio:80`                                |
| `global.host`                      |                    | `example.com`                                    |
| `global.rbac.serviceAccountName`   |                    | `null`                                           |

Global paramater works only if the local chart parameter is null.
(#TODO refactor merge of global and local params)

| Parameter                          | Description                 | Default                                          |
|------------------------------------|-----------------------------|--------------------------------------------------|
| `host`                             |  Used in ambassador mappings| `example.com`                                    |
| `image.registry`                   |  docker image registry      | `ecr`                                           |
| `image.tag`                        |  docker image tag           | `latest`                                |
| `imagePullPolicy`                  |  image pull policy          | `always`                                    |
| `replicaCount`                     |  number of pods             | `1`                                           |