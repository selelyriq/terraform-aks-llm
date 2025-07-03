# terraform-aks-llm


docker run -ti --name local-ai -p 8080:8080 localai/localai:latest

az aks get-credentials --resource-group rg-localai-dev --name aks-localai-dev-cluster

kubectl exec -n localai -it localai-5cbfb6f875-nbpcn -- curl http://localhost:3000

kubectl port-forward svc/prometheus-node-exporter -n prometheus 9090:9100