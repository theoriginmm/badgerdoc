
cat ./infra/helm/keycloack/clean_keycloak.sql | kubectl -n ${NAMESPACE} exec -ti postgres-postgresql-0 -- \
bash -c 'PGPASSWORD=postgres psql -U postgres keycloak'

helm install bagerdoc-keycloack -n ${NAMESPACE} -f ./infra/helm/keycloack/values.yaml --version 6.0.1 \
--set  externalDatabase.password=postgres \
--set externalDatabase.user=postgres  \
--set externalDatabase.host=postgres-postgresql \
bitnami/keycloak

kubectl -n ${NAMESPACE} apply -f - <<EOF
apiVersion: getambassador.io/v2
kind: Mapping
metadata:
  name: bagerdoc-keycloack
  namespace: ${NAMESAPCE}
spec:
  connect_timeout_ms: 2000
  host: ${NAMESPACE}.badgerdoc.com
  idle_timeout_ms: 50000
  prefix: /auth
  rewrite: ""
  service: bagerdoc-keycloack
  timeout_ms: 4000
EOF


DNS_CONFIG=$(kubectl -n kube-system get configmap coredns -o json)

if [[ $OSTYPE == *linux* ]]; then CONFIG=$(echo $DNS_CONFIG | grep -oP '(?<="Corefile": ")[^"]*'); fi
if [[ $OSTYPE == *darwin* ]]; then CONFIG=$(echo $DNS_CONFIG | jq ".data.Corefile" | tr -d '"'); fi

NEW_DNS_CONFIG=$(echo ${CONFIG} | sed "s@ready@ready\\\n    rewrite name ${NAMESPACE}.badgerdoc.com ambassador.ambassador.svc.cluster.local@g")

kubectl -n kube-system patch configmap coredns -p '{"data": { "Corefile": "'"${NEW_DNS_CONFIG}"'" }}'
