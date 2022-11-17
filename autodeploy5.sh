
helm install kafka -n ${NAMESPACE} -f infra/helm/apache-kafka/values.yaml --version 15.0.1  bitnami/kafka


helm install gotenberg infra/helm/gotenberg/ -n ${NAMESPACE}


# TODO: deploy elastic
# requires: sysctl -w vm.max_map_count=262144
