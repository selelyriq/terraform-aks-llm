# Documentation Reference: https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release
# Resource to install ArgoCD
resource "helm_release" "argocd" {
  name             = "argocd"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true
  repository       = "https://argoproj.github.io/argo-helm"
  version          = "5.34.5"
  values = [
    file("${path.module}/argocd/values.yaml")
  ]
}

# Documentation Reference: https://github.com/prometheus-community/helm-charts/
# Resource to install Prometheus
resource "helm_release" "prometheus" {
  name             = "prometheus"
  chart            = "prometheus"
  namespace        = "prometheus"
  create_namespace = true
  repository       = "https://prometheus-community.github.io/helm-charts"
  version          = "15.15.0"
  values = [
    file("${path.module}/prometheus/values.yaml")
  ]
}

# Documentation Reference: https://github.com/grafana/helm-charts/blob/main/charts/grafana/README.md
# Resource to install Grafana
resource "helm_release" "grafana" {
  name             = "grafana"
  chart            = "grafana"
  namespace        = "grafana"
  create_namespace = true
  repository       = "https://grafana.github.io/helm-charts"
  version          = "6.55.0"
  values = [
    file("${path.module}/grafana/values.yaml")
  ]
}