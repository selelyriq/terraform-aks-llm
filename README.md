# Terraform AKS LLM Infrastructure

A comprehensive Infrastructure as Code (IaC) solution for deploying an Azure Kubernetes Service (AKS) cluster with Local AI capabilities, photo management, monitoring, and GitOps workflow management.

## 🎯 Project Overview

This project provides a complete infrastructure setup for running Large Language Models (LLMs) and related applications on Azure Kubernetes Service. It combines Terraform for infrastructure provisioning with Kubernetes manifests for application deployment, creating a production-ready environment for AI workloads.

### Key Features

- **🔧 Infrastructure as Code**: Terraform-based AKS cluster provisioning
- **🤖 Local AI**: Self-hosted AI/LLM capabilities using LocalAI
- **📸 Photo Management**: PhotoPrism for photo organization and management
- **📊 Monitoring Stack**: Prometheus, Grafana, and Node Exporter for comprehensive monitoring
- **🚀 GitOps**: ArgoCD for continuous deployment and application management
- **🔒 Security**: Certificate management with cert-manager and security policies
- **🌐 Ingress**: NGINX Ingress Controller for traffic management
- **📋 Policy Enforcement**: OPA (Open Policy Agent) for Kubernetes resource validation

## 🏗️ Architecture

### Infrastructure Components

- **Azure Kubernetes Service (AKS)**: Managed Kubernetes cluster
- **Azure Log Analytics**: Centralized logging and monitoring
- **Azure Resource Groups**: Organized resource management
- **Network Security Groups**: Traffic control and security

### Application Stack

- **LocalAI**: Open-source alternative to OpenAI's API
- **PhotoPrism**: AI-powered photo management
- **Prometheus**: Metrics collection and alerting
- **Grafana**: Visualization and dashboards
- **ArgoCD**: GitOps continuous deployment
- **NGINX Ingress**: Load balancing and traffic routing
- **Cert-Manager**: Automatic TLS certificate management

## 📋 Prerequisites

Before you begin, ensure you have the following installed and configured:

### Required Tools

```bash
# Azure CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Terraform (version ~> 1.12.2)
wget https://releases.hashicorp.com/terraform/1.12.2/terraform_1.12.2_linux_amd64.zip
unzip terraform_1.12.2_linux_amd64.zip
sudo mv terraform /usr/local/bin/

# kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Helm (optional, for manual chart management)
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
```

### Azure Setup

1. **Azure Subscription**: Active Azure subscription with appropriate permissions
2. **Service Principal** (recommended for CI/CD):
   ```bash
   az ad sp create-for-rbac --name "terraform-aks-sp" --role="Contributor" --scopes="/subscriptions/YOUR_SUBSCRIPTION_ID"
   ```

3. **Azure CLI Authentication**:
   ```bash
   az login
   az account set --subscription "YOUR_SUBSCRIPTION_ID"
   ```

## 🚀 Quick Start

### 1. Clone and Setup

```bash
git clone <repository-url>
cd tf-aks-llm
```

### 2. Configure Variables

Edit `terraform-patterns/standard/variables.tf` or create a `terraform.tfvars` file:

```hcl
project_name = "localai"    # Your project name
environment  = "dev"        # Environment (dev/staging/prod)
location     = "centralus"  # Azure region
```

### 3. Deploy Infrastructure

```bash
cd terraform-patterns/standard

# Initialize Terraform
terraform init

# Plan the deployment
terraform plan

# Apply the infrastructure
terraform apply
```

### 4. Get AKS Credentials

After successful deployment, configure kubectl to connect to your cluster:

```bash
az aks get-credentials --resource-group rg-localai-dev --name aks-localai-dev-cluster
```

### 5. Deploy Applications

```bash
# Navigate back to project root
cd ../../

# Apply LocalAI manifests
kubectl apply -f app-manifests/01-localai/templates/

# Apply PhotoPrism manifests (optional)
kubectl apply -f app-manifests/02-photoprisma/

# Apply ArgoCD configuration
kubectl apply -f app-manifests/03-argocd/

# Apply Ingress configurations
kubectl apply -f app-manifests/04-ingress/
```

## 🔧 Usage and Management

### Accessing Services

#### LocalAI
```bash
# Port forward to access LocalAI locally
kubectl port-forward svc/localai -n localai 8080:80

# Or access via exec into pod for testing
kubectl exec -n localai -it localai-5cbfb6f875-nbpcn -- curl http://localhost:3000
```

#### Prometheus Monitoring
```bash
# Access Prometheus Node Exporter
kubectl port-forward svc/prometheus-node-exporter -n prometheus 9090:9100
```

#### Grafana Dashboard
```bash
# Port forward Grafana
kubectl port-forward svc/grafana -n grafana 4000:80

# Get Grafana admin password
kubectl get secret --namespace grafana grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo
```

#### ArgoCD UI
```bash
# Port forward ArgoCD server
kubectl port-forward svc/argocd-server -n argocd 8080:443

# Get ArgoCD admin password
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 --decode ; echo
```

### Running LocalAI Locally (Development)

For local development and testing:

```bash
docker run -ti --name local-ai -p 8080:8080 localai/localai:latest
```

## 📁 Project Structure

```
tf-aks-llm/
├── terraform-patterns/standard/    # Main Terraform configuration
│   ├── main.tf                    # Provider and module configuration
│   ├── aks-cluster.tf            # AKS cluster resources
│   ├── variables.tf              # Input variables
│   ├── outputs.tf                # Output values
│   ├── resource-group.tf         # Azure resource groups
│   ├── log-analytics.tf          # Logging configuration
│   └── helm-charts/              # Helm chart installations
│       ├── tool-install.tf       # Helm releases
│       ├── argocd/values.yaml    # ArgoCD configuration
│       ├── grafana/values.yaml   # Grafana configuration
│       ├── prometheus/values.yaml # Prometheus configuration
│       └── nginx-ingress/values.yaml # Ingress configuration
├── app-manifests/                 # Kubernetes application manifests
│   ├── 01-localai/               # LocalAI deployment
│   ├── 02-photoprisma/           # PhotoPrism application
│   ├── 03-argocd/                # ArgoCD configuration
│   └── 04-ingress/               # Ingress and certificates
└── scanning/                     # Policy and validation
    ├── policy/                   # OPA Rego policies
    └── schemas/                  # JSON schemas for validation
```

## 🔒 Security Features

### Policy Enforcement
- **OPA Policies**: Deployment validation using Open Policy Agent
- **Security Contexts**: Non-root containers with read-only filesystems
- **RBAC**: Role-based access control for all services
- **Network Security**: Network Security Groups with HTTP/HTTPS rules

### Certificate Management
- **Cert-Manager**: Automatic TLS certificate provisioning
- **Let's Encrypt**: Free SSL certificates for production workloads

## 🔍 Monitoring and Observability

### Metrics Collection
- **Prometheus**: Scrapes metrics from all cluster components
- **Node Exporter**: System-level metrics from cluster nodes
- **Grafana**: Visualization dashboards for metrics

### Logging
- **Azure Log Analytics**: Centralized log collection
- **Microsoft Defender**: Security monitoring and threat detection

## 🛠️ Customization

### Scaling Applications
Modify replica counts in deployment manifests:
```yaml
spec:
  replicas: 3  # Increase for higher availability
```

### Adding New Applications
1. Create manifests in `app-manifests/`
2. Add to ArgoCD for GitOps management
3. Update ingress rules as needed

### Environment Configuration
Create environment-specific variable files:
```bash
# terraform.dev.tfvars
project_name = "localai"
environment  = "dev"
location     = "eastus"

# terraform.prod.tfvars
project_name = "localai"
environment  = "prod"
location     = "westus2"
```

## 🚨 Troubleshooting

### Common Issues

#### AKS Cluster Access
```bash
# Verify cluster connection
kubectl cluster-info

# Check node status
kubectl get nodes

# Verify all pods are running
kubectl get pods --all-namespaces
```

#### Application Deployment
```bash
# Check deployment status
kubectl get deployments --all-namespaces

# View pod logs
kubectl logs -f deployment/localai -n localai

# Describe problematic resources
kubectl describe pod <pod-name> -n <namespace>
```

#### Terraform Issues
```bash
# Refresh state
terraform refresh

# Import existing resources if needed
terraform import azurerm_resource_group.rg /subscriptions/SUB_ID/resourceGroups/RG_NAME
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines
- Follow Terraform best practices
- Test infrastructure changes in development environment
- Update documentation for new features
- Validate Kubernetes manifests before committing

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

For support and questions:
- Create an issue in this repository
- Check existing documentation and troubleshooting guides
- Review Azure AKS documentation for platform-specific issues

---

**Note**: This project is designed for educational and development purposes. For production deployments, ensure proper security reviews, backup strategies, and monitoring are in place.