local development

curl https://raw.githubusercontent.com/minio/docs/master/source/extra/examples/minio-dev.yaml -O
microk8s kubectl apply -f minio-dev.yaml

microk8s kubectl port-forward pod/minio 9000 9090 -n minio-dev