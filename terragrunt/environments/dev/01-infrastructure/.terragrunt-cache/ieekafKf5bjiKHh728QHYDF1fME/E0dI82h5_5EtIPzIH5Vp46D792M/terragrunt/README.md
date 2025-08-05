# Terragrunt Infrastructure

This directory contains the Terragrunt configuration for deploying the AKS cluster and its add-ons. The infrastructure is split into two main components:

-   `core-cluster`: Deploys the core Azure resources, including the AKS cluster, VNet, and node pools.
-   `cluster-addons`: Deploys the add-ons to the cluster, such as ArgoCD, Prometheus, Grafana, and LocalAI.

## Directory Structure

-   `environments/`: Contains the Terragrunt configurations for each environment (e.g., `dev`, `staging`, `prod`).
    -   `dev/`: The `dev` environment.
        -   `core-cluster/`: The Terragrunt configuration for the `core-cluster` module.
        -   `cluster-addons/`: The Terragrunt configuration for the `cluster-addons` module.
        -   `terragrunt.hcl`: The root Terragrunt configuration for the `dev` environment.
-   `modules/`: Contains the Terraform modules.
    -   `core-cluster/`: The Terraform module for the core cluster.
    -   `cluster-addons/`: The Terraform module for the cluster add-ons.

## Usage

To deploy the infrastructure, navigate to the `environments/dev` directory and run the following command:

```bash
terragrunt apply-all
```

This will deploy the `core-cluster` module first, followed by the `cluster-addons` module. Terragrunt will automatically manage the dependencies between the two modules.
