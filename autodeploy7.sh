

eval $(minikube docker-env)

export REGISTRY="local/badgerdoc"
export image_name="${REGISTRY}/python_base:0.1.7"

cd infra/docker/python_base
make build
cd -

SERVICES="assets \
jobs \
pipelines \
search \
annotation \
processing \
models \
users \
convert \
scheduler"

apphostname="${NAMESPACE}.badgerdoc.com"

for svc in $SERVICES; do 
cd ${svc};
version=$(cat version.txt)
sha=$(git rev-parse --short HEAD)
tag="${version}-${sha}"
image="${REGISTRY}/${svc}:${version}-${sha}"
docker build --target build -t "${image}" . --build-arg "base_image=${image_name}"
helm upgrade -n ${NAMESPACE} -i --set image.registry=${REGISTRY},app.hostname=${apphostname},image.tag=${tag} --version ${tag}  ${svc}  ./chart/
cd .. 
done
