
# Create storage class for minikube
kubectl apply -f - <<EOF
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  annotations:
  labels:
    addonmanager.kubernetes.io/mode: EnsureExists
  name: ebs-sc
provisioner: k8s.io/minikube-hostpath
reclaimPolicy: Delete
volumeBindingMode: Immediate
EOF


helm install postgres -n ${NAMESPACE} bitnami/postgresql -f infra/helm/postgres/values.yaml --version 10.14.3

# TODO: init job with waiter

sleep 90

DATABASE='create database annotation;
create database job_manager;
create database file_management;
create database models;
create database pipelines;
create database processing;
create database users;
create database scheduler;
create database keycloak;
'

echo $DATABASE | kubectl -n ${NAMESPACE} exec -i postgres-postgresql-0 -- bash -c 'PGPASSWORD=postgres psql -U postgres'

kubectl -n ${NAMESPACE} exec  postgres-postgresql-0 -- bash -c 'PGPASSWORD=postgres psql -U postgres annotation -c "create extension ltree;"'

