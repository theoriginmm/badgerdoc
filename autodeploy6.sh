ADMIN_CLIENT_SECRET_DEV1=149ea871-ced4-4672-a9be-3fe3502afb3e #keycloak      Clients → master-realm 
ANNOTATION_POSTGRES_PASSWORD=postgres
ANNOTATION_POSTGRES_USER=postgres
ANNOTATION_S3_LOGIN=serviceuser #minio
ANNOTATION_S3_PASS=12345678 #minio
ASSETS_JWT_SECRET=LS0tLS1CRUdJTiBQVUJMSUMgS0VZLS0tLS0KTUlJQklqQU5CZ2txaGtpRzl3MEJBUUVGQUFPQ0FROEFNSUlCQ2dLQ0FRRUFtb2FPcTE4ZU5tYmQ5QkEyQTBiRVZ3TFQ4R2JBY2NMNDZRcXpsbFVvSW02YTZUVE1JQzFsNVNQSUY2RFc5Q0c4cU1XZHdZVjQ5TWx5NXp5ZHZUMk9aNVpSZmJWN0VDelFXVGdLeTFRRHR2WWhNVEZsZkVhU1lxVGI5VGNmeFB6R1IzZGpnU1lzR3RJSFF0cVFwN2plZXkzQi8zUmFzYm81Q1FJWUdxZ0xNS2NEOUErSHZNQnErMENXcllGOVBuem95bCtIV2kySmREajNTWjNLVVdhN0RJRE9GdXdxdE9IQ0ZBRXJNNTNadVJGeStqV3lzalV6ZHRXMkhMM1k3dnRDL1RSY2hsWlJjVS9FWDd2SnBUdU8zT0RRSzgydDZJL2JaUzVTMFJBOEhlNngwUVZXTFpCd2xwSTY2Y0s0SmcvOTBuRHRsdDUyWmxMcnNBTFlIaW5tTHdJREFRQUIKLS0tLS1FTkQgUFVCTElDIEtFWS0tLS0tCg==
#keycloak  Master Realm → Realm Settings → Keys → Public Key 
# -----BEGIN PUBLIC KEY----- … -----END PUBLIC KEY----- | base64	
BADGERDOC_CLIENT_SECRET_DEV1=58f14c39-3afa-4bfe-9bf9-86250f854a0a #keycloak:      Clients → BadgerDoc  
DATASET_DATABASE_URL=postgresql+psycopg2://postgres:postgres@postgres-postgresql:5432/file_management
DATASET_MINIO_ACCESS_KEY=serviceuser
DATASET_MINIO_SECRET_KEY=12345678
DATASET_POSTGRES_PASSWORD=postgres
DATASET_POSTGRES_USER=postgres
NAMESPACE=app
INFERENCE_MANAGER_DB_PASSWORD=postgres
INFERENCE_MANAGER_DB_URL=postgresql+psycopg2://postgres:postgres@postgres-postgresql:5432/pipelines
INFERENCE_MANAGER_DB_USERNAME=postgres
JOBMANAGER_POSTGRESQL_DATABASE_URI=postgresql+psycopg2://postgres:postgres@postgres-postgresql:5432/job_manager
KEYCLOAK_DIRECT_ENDPOINT_DEV1=http://app.badgerdoc.com
MODELS_DATABASE_URL=postgresql+psycopg2://postgres:postgres@postgres-postgresql:5432/models
MODELS_MINIO_ACCESS_KEY=serviceuser
MODELS_MINIO_SECRET_KEY=12345678
MODELS_POSTGRES_PASSWORD=postgres
MODELS_POSTGRES_USER=postgres
PIPELINES_CLIENT_SECRET_KEY_DEV1=086e88d5-0f8a-48aa-9116-0f13cb753b28 #keycloak:        Clients → pipelines 
PIPELINES_MINIO_ACCESS_KEY=serviceuser
PIPELINES_MINIO_SECRET_KEY=12345678
PREPROCESSING_MINIO_ROOT_PASSWORD=12345678
PREPROCESSING_MINIO_ROOT_USER=serviceuser
SEARCH_S3_LOGIN=serviceuser
SEARCH_S3_PASS=12345678
USERS_DATABASE_URL=postgresql+psycopg2://postgres:postgres@postgres-postgresql:5432/users
USERS_MINIO_ACCESS_KEY=serviceuser
USERS_MINIO_SECRET_KEY=12345678
USERS_POSTGRES_PASSWORD=postgres
USERS_POSTGRES_USER=postgres

kubectl delete secret -n ${NAMESPACE} annotation --ignore-not-found
kubectl create secret -n ${NAMESPACE} generic annotation --from-literal=POSTGRES_USER=${ANNOTATION_POSTGRES_USER} --from-literal=POSTGRES_PASSWORD=${ANNOTATION_POSTGRES_PASSWORD} --from-literal=S3_LOGIN=${ANNOTATION_S3_LOGIN} --from-literal=S3_PASS=${ANNOTATION_S3_PASS}

kubectl delete secret -n ${NAMESPACE} assets --ignore-not-found
kubectl create secret -n ${NAMESPACE} generic assets --from-literal=POSTGRES_USER=${DATASET_POSTGRES_USER} --from-literal=POSTGRES_PASSWORD=${DATASET_POSTGRES_PASSWORD} --from-literal=MINIO_ACCESS_KEY=${DATASET_MINIO_ACCESS_KEY} --from-literal=MINIO_SECRET_KEY=${DATASET_MINIO_SECRET_KEY} --from-literal=DATABASE_URL=${DATASET_DATABASE_URL} --from-literal=JWT_SECRET=${ASSETS_JWT_SECRET}

kubectl delete secret -n ${NAMESPACE} jobs --ignore-not-found
kubectl create secret -n ${NAMESPACE} generic jobs --from-literal=POSTGRESQL_JOBMANAGER_DATABASE_URI=${JOBMANAGER_POSTGRESQL_DATABASE_URI}

kubectl delete secret -n ${NAMESPACE} pipelines --ignore-not-found
kubectl create secret -n ${NAMESPACE} generic pipelines --from-literal=DB_USERNAME=${INFERENCE_MANAGER_DB_USERNAME} \
--from-literal=DB_PASSWORD=${INFERENCE_MANAGER_DB_PASSWORD} --from-literal=DB_URL=${INFERENCE_MANAGER_DB_URL} \
--from-literal=MINIO_ACCESS_KEY=${PIPELINES_MINIO_ACCESS_KEY} --from-literal=MINIO_SECRET_KEY=${PIPELINES_MINIO_SECRET_KEY} \
--from-literal=PIPELINES_CLIENT_SECRET_KEY_DEV1=${PIPELINES_CLIENT_SECRET_KEY_DEV1} 

kubectl delete secret -n ${NAMESPACE} search --ignore-not-found
kubectl create secret -n ${NAMESPACE} generic search --from-literal=S3_LOGIN=${SEARCH_S3_LOGIN} --from-literal=S3_PASS=${SEARCH_S3_PASS}

kubectl delete secret -n ${NAMESPACE} preprocessing --ignore-not-found
kubectl create secret -n ${NAMESPACE} generic preprocessing --from-literal=MINIO_ROOT_USER=${PREPROCESSING_MINIO_ROOT_USER} --from-literal=MINIO_ROOT_PASSWORD=${PREPROCESSING_MINIO_ROOT_PASSWORD}

kubectl delete secret -n ${NAMESPACE} models --ignore-not-found
kubectl create secret -n ${NAMESPACE} generic models --from-literal=POSTGRES_USER=${MODELS_POSTGRES_USER} --from-literal=POSTGRES_PASSWORD=${MODELS_POSTGRES_PASSWORD} --from-literal=MINIO_ACCESS_KEY=${MODELS_MINIO_ACCESS_KEY} --from-literal=MINIO_SECRET_KEY=${MODELS_MINIO_SECRET_KEY} --from-literal=DATABASE_URL=${MODELS_DATABASE_URL}

kubectl delete secret -n ${NAMESPACE} users --ignore-not-found
kubectl create secret -n ${NAMESPACE} generic users --from-literal=POSTGRES_USER=${USERS_POSTGRES_USER} \
--from-literal=POSTGRES_PASSWORD=${USERS_POSTGRES_PASSWORD} \
--from-literal=MINIO_ACCESS_KEY=${USERS_MINIO_ACCESS_KEY} \
--from-literal=MINIO_SECRET_KEY=${USERS_MINIO_SECRET_KEY} \
--from-literal=DATABASE_URL=${USERS_DATABASE_URL} \
--from-literal=KEYCLOAK_DIRECT_ENDPOINT_DEV1=${KEYCLOAK_DIRECT_ENDPOINT_DEV1} \
--from-literal=BADGERDOC_CLIENT_SECRET_DEV1=${BADGERDOC_CLIENT_SECRET_DEV1} \
--from-literal=ADMIN_CLIENT_SECRET_DEV1=${ADMIN_CLIENT_SECRET_DEV1} 

kubectl delete secret -n ${NAMESPACE} processing --ignore-not-found
kubectl create secret -n ${NAMESPACE} generic processing --from-literal=MINIO_ROOT_USER=${MODELS_MINIO_ACCESS_KEY} --from-literal=MINIO_ROOT_PASSWORD=${MODELS_MINIO_SECRET_KEY}

