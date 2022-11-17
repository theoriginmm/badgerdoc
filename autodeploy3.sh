sed -i'.orig' "s/dev1/${NAMESPACE}/g" infra/helm/minio/values.yaml

helm install --namespace minio-operator --create-namespace --generate-name minio/minio-operator -f infra/helm/minio/values.yaml

kubectl apply -f - <<EOF
apiVersion: getambassador.io/v2
kind: Mapping
metadata:
  annotations:
  name: minio1-console
  namespace: ${NAMESPACE}
spec:
  allow_upgrade:
  - websocket
  connect_timeout_ms: 10000
  host: minio1.${NAMESPACE}.badgerdoc.com
  idle_timeout_ms: 50000
  keepalive:
    interval: 10
    probes: 9
    time: 100
  prefix: /
  service: minio1-console:9090
  timeout_ms: 0
EOF

sleep 2

RESPONSE=$(curl -s "http://minio1.${NAMESPACE}.badgerdoc.com/api/v1/login" -X POST -H 'Content-Type: application/json' \
--data '{"accessKey":"minioadmin","secretKey":"minioadmin"}')

if [[ $OSTYPE == *linux* ]]; then TOKEN=$(echo $RESPONSE | grep -oP '(?<="sessionId":")[^"]*'); fi
if [[ $OSTYPE == *darwin* ]]; then TOKEN=$(echo $RESPONSE | jq ".sessionId" -r); fi

curl -s "http://minio1.${NAMESPACE}.badgerdoc.com/api/v1/buckets" -X POST -H 'Content-Type: application/json' -H "Cookie: token=${TOKEN}" \
--data '{"name":"test","versioning":false,"locking":false}'

curl -s "http://minio1.${NAMESPACE}.badgerdoc.com/api/v1/users" -X POST -H 'Content-Type: application/json' -H "Cookie: token=${TOKEN}" \
--data '{"accessKey":"serviceuser","secretKey":"12345678","groups":[],"policies":["readwrite"]}'

