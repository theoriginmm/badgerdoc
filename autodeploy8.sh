

eval $(minikube docker-env)

export REGISTRY="local/badgerdoc"

svc='badgerdoc_ui'
version=$(cat ./web/version.txt)
sha=$(git rev-parse --short HEAD)
tag="${version}-${sha}"
image="${REGISTRY}/${svc}:${version}-${sha}"
DOCKERFILE="./web/deploy/web.Dockerfile"

cp -r .git ./web/ || true
docker build -t ${image} --no-cache=true --pull --file $DOCKERFILE ./web
rm -rf ./web/.git

helm upgrade -n ${NAMESPACE} -i --set image.registry=${REGISTRY},image.tag=${tag} badgerdoc-ui-dev ./web/chart/.
