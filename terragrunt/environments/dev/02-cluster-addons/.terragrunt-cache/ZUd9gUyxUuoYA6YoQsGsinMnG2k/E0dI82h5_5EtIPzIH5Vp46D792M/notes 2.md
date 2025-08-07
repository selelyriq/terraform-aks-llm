az aks get-credentials --resource-group rg-localai-dev --name aks-localai-dev-cluster

kubectl exec -n localai -it localai-5cbfb6f875-nbpcn -- curl http://localhost:3000
kubectl exec -n localai -it localai-5cbfb6f875-nbpcn -- curl http://localhost:3000

kubectl port-forward svc/prometheus-node-exporter -n prometheus 9090:9100

kubectl port-forward svc/grafana -n grafana 4000:80

kubectl get secret --namespace grafana grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

