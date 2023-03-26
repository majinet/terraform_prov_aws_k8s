Disable Cache

export NAMESPACE=<Namespace where KFP is installed>
kubectl get mutatingwebhookconfiguration cache-webhook-${NAMESPACE}

kubectl patch mutatingwebhookconfiguration cache-webhook-${NAMESPACE} --type='json' -p='[{"op":"replace", "path": "/webhooks/0/rules/0/operations/0", "value": "DELETE"}]'

kubectl port-forward -n kubeflow svc/ml-pipeline-ui 8080:80