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

resource "helm_release" "node_exporter" {
  name       = "node-exporter"
  namespace  = "monitoring"
  chart      = "prometheus-node-exporter"
  repository = "https://prometheus-community.github.io/helm-charts"
  version    = "4.24.0" # Check https://artifacthub.io/packages/helm/prometheus-community/prometheus-node-exporter

  create_namespace = true

  values = [
    file("${path.module}/node-exporter/values.yaml")
  ]
}

resource "helm_release" "ingress" {
  name             = "ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "ingress-nginx"
  create_namespace = true
  repository       = "https://kubernetes.github.io/ingress-nginx"
  version          = "4.12.3"
  values = [
    file("${path.module}/nginx-ingress/values.yaml")
  ]
  depends_on = [helm_release.cert_manager]
}

resource "helm_release" "cert_manager" {
  name             = "cert-manager"
  repository       = "https://charts.jetstack.io"
  chart            = "cert-manager"
  version          = "1.14.3"
  namespace        = "cert-manager"
  create_namespace = true

  set {
    name  = "installCRDs"
    value = "true"
  }
}

resource "kubernetes_manifest" "argocd_app" {
  manifest = yamldecode(file("${path.root}/../../app-manifests/03-argocd/01-argocd-config.yaml"))

  depends_on = [helm_release.argocd]
}

resource "kubernetes_manifest" "photoprism_app" {
  manifest = yamldecode(file("${path.root}/../../app-manifests/03-argocd/02-photoprism-config.yaml"))

  depends_on = [helm_release.argocd]
}