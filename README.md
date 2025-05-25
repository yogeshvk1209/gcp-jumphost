# GCP Jump Host

A Terraform configuration to provision a GCP Compute Engine instance that serves as a jump host for GCP infrastructure automation.

## Features

- Uses GCP Compute Engine with Spot instance pricing for cost optimization
- Smallest possible instance type (e2-micro)
- CentOS latest image
- Custom firewall rules for SSH access
- SSH key-based authentication
- Located in default VPC network

## Prerequisites

- Terraform installed
- GCP account and project set up
- gcloud CLI installed and configured
- SSH key pair generated

## Installation

1. Initialize Terraform:
```bash
terraform init
```

2. Review the plan:
```bash
terraform plan
```

3. Apply the configuration:
```bash
terraform apply --auto-approve
```

## Accessing the Jump Host

Once provisioned, you can SSH into the instance using:
```bash
ssh -i ~/.ssh/id_rsa USERNAME@EXTERNAL_IP
```

The external IP will be shown in the Terraform outputs.

## Cleanup

To destroy all resources:
```bash
terraform destroy --auto-approve
```

## License

Free to use and modify as needed.