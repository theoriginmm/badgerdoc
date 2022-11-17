
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


helm install postgres -n app bitnami/postgresql -f infra/helm/postgres/values.yaml --version 10.14.3
