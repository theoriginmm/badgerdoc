minikube delete

minikube start  --memory 10000 --cpus 4 --kubernetes-version v1.21.4

helm repo add datawire https://www.getambassador.io
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add minio https://operator.min.io/
helm repo update

# Install istio:
export ISTIO_VERSION=1.11.4
curl -sL https://istio.io/downloadIstioctl | sh -
$HOME/.istioctl/bin/istioctl manifest install -y -f - <<EOF
apiVersion: install.istio.io/v1alpha1
kind: IstioOperator
spec:
  meshConfig:
    extensionProviders:
    - name: oauth2-proxy
      envoyExtAuthzHttp:
        service: oauth2-proxy.oauth2-proxy.svc.cluster.local
        port: 4180
        includeRequestHeadersInCheck:
        - cookie
        headersToUpstreamOnAllow:
        - authorization
        headersToDownstreamOnDeny:
        - set-cookie
EOF

# Replace istio-ingressgateway with NodePort:
kubectl delete svc istio-ingressgateway -n istio-system
sleep 1
kubectl apply -f infra/k8s/helm/istio/patched_istio_svc.yaml

# Create Ambassador
kubectl apply -f infra/k8s/helm/ambassador/aes-crds.yaml
kubectl create namespace ambassador
helm install ambassador --namespace ambassador datawire/ambassador --version "6.9.3" -f infra/k8s/helm/ambassador/ambassador.values.yaml
kubectl patch deployment ambassador -n ambassador --patch "$(cat infra/k8s/helm/ambassador/ambassador.patch.yaml)"
kubectl apply -f infra/k8s/helm/ambassador/ambassador.host.yaml
kubectl apply -f infra/k8s/helm/ambassador/ambassador.module.yaml

# Replace istio-ingressgateway with NodePort:
kubectl delete svc istio-ingressgateway -n istio-system
sleep 1
kubectl apply -f infra/k8s/helm/istio/patched_istio_svc.yaml

# Install knative:

sed -i "s/dev1/${NAMESPACE}/g" infra/k8s/knative/rbac.yaml

kubectl create ns knative-serving
kubectl apply -f infra/k8s/knative/operator.yaml
sleep 10
kubectl apply -f infra/k8s/knative/knative_serving.yaml
kubectl apply -f infra/k8s/knative/domain.configuration.yaml
kubectl label namespace knative-serving istio-injection=enabled

# Prepare for application
kubectl create ns ${NAMESPACE}
kubectl label namespace ${NAMESPACE} istio-injection=enabled
