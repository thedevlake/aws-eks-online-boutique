# Deploying Google Online Boutique on AWS EKS

A hands-on cloud engineering project deploying Google's Online Boutique microservices demo to Amazon EKS using Terraform and Kubernetes.

## Project Overview

This project provisions AWS infrastructure with Terraform and deploys the Online Boutique application to a managed Kubernetes cluster.

It explores infrastructure as code, Kubernetes workloads, AWS networking, load balancing, and troubleshooting real deployment issues.

## Architecture

**Request flow:**

Internet → AWS Load Balancer → Online Boutique frontend → Internal microservices

**Infrastructure:**
- Amazon VPC and subnets
- Internet Gateway and routing
- Amazon EKS cluster
- EKS managed worker nodes
- EKS cluster add-ons
- Kubernetes Deployments and Services
- External LoadBalancer service for the frontend

## Tech Stack

- AWS: EKS, EC2, VPC, Elastic Load Balancing, IAM
- Terraform
- Kubernetes
- kubectl
- AWS CLI
- Google CloudPlatform's Online Boutique demo

## What I've Implemented

- Provisioned AWS infrastructure using Terraform.
- Configured an Amazon EKS cluster and managed node group.
- Deployed the Online Boutique Kubernetes manifests.
- Exposed the frontend through an AWS load balancer.
- Investigated pod scheduling failures caused by worker-node pod capacity.
- Scaled the worker-node group to provide sufficient capacity.
- Verified that the application pods reached `1/1 Ready`.

## Repository Structure

```text
.
├── terraform-aws/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── versions.tf
│   └── .terraform.lock.hcl
├── kubernetes/
│   └── online-boutique.yaml
├── docs/
├── .gitignore
└── README.md
```

## Deployment

### Prerequisites

- An AWS account with appropriate permissions
- AWS CLI configured with your credentials
- Terraform
- kubectl

### 1. Provision the infrastructure

```bash
cd terraform-aws
terraform init
```

Provide your own public IPv4 address in CIDR notation, using `/32` for one IPv4 address. Do not commit your local `terraform.tfvars` file.

Example local `terraform.tfvars`:

```hcl
admin_cidr = "YOUR_PUBLIC_IP/32"
```

Then review and apply the infrastructure:

```bash
terraform plan
terraform apply
```

Review the plan carefully before approving any changes.

### 2. Configure kubectl

```bash
aws eks update-kubeconfig \
  --region eu-west-1 \
  --name online-boutique-eks
```

### 3. Deploy the application

From the repository root:

```bash
kubectl apply -f kubernetes/online-boutique.yaml
```

### 4. Verify the deployment

```bash
kubectl get nodes
kubectl get pods
kubectl get services
```

Find the frontend's external address:

```bash
kubectl get service frontend-external
```

Open the external address in a browser using HTTP if the service is configured for HTTP.

## Cleanup

When you no longer need the environment, remove the application resources:

```bash
kubectl delete -f kubernetes/online-boutique.yaml
```

Then, from the Terraform directory, review the destruction plan before deleting the infrastructure:

```bash
terraform plan -destroy
terraform destroy
```

Confirm that you are targeting the intended resources. AWS resources may incur charges while they exist.

## Future Improvements

- Add a GitHub Actions CI/CD workflow.
- Automate deployment validation.
- Add monitoring and observability.
- Document the architecture with a diagram.
- Improve cost monitoring and operational documentation.

## Acknowledgements

The application is Google's open-source [Online Boutique](https://github.com/GoogleCloudPlatform/microservices-demo), used here as a practical deployment target for learning AWS and Kubernetes.
