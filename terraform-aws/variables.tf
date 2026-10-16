variable "aws_region" {
  description = "AWS region for the EKS cluster"
  type        = string
  default     = "eu-west-1"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "online-boutique-eks"
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.34"
}

variable "admin_cidr" {
  description = "Public IPv4 CIDR allowed to access the Kubernetes API, e.g. your-ip/32"
  type        = string
}
