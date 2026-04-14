# Cloud Infrastructure — Terraform + AWS

![Terraform](https://img.shields.io/badge/Terraform-IaC-purple)
![AWS](https://img.shields.io/badge/AWS-S3-orange)
![Free Tier](https://img.shields.io/badge/Cost-Free%20Tier-green)

Infrastructure as Code project using Terraform to provision and manage AWS cloud resources. All infrastructure is defined in code, version controlled, and reproducible with a single command.

## What this project demonstrates

- Writing infrastructure as code using Terraform — no manual clicking in cloud consoles
- Provisioning real AWS cloud resources (S3 bucket) from a config file
- Understanding the full Terraform workflow: init → plan → apply → destroy
- Safe credential and state file management using .gitignore
- Version controlling infrastructure the same way you version control application code

## Live infrastructure

AWS S3 bucket provisioned via Terraform in the `us-east-1` region.
Destroyed after use — run `terraform apply` to reproduce it in under 30 seconds.

## Tech stack

| Tool | Purpose |
|---|---|
| Terraform | Infrastructure as Code |
| AWS S3 | Cloud storage resource |
| AWS CLI | Authentication and access |
| Git | Version control |

## Project structure

```text
my-terraform-infra/
├── main.tf        # All infrastructure defined here
└── .gitignore     # Keeps state files and credentials off GitHub
```

## How to run it yourself

**Prerequisites:** Terraform installed, AWS CLI installed, AWS account configured

```bash
git clone https://github.com/Cindy-Milan/my-terraform-infra
cd my-terraform-infra
```

Initialize Terraform — downloads the AWS provider:
```bash
terraform init
```

Preview what will be created — no changes made yet:
```bash
terraform plan
```

Build the infrastructure:
```bash
terraform apply
```

Tear it all down when done:
```bash
terraform destroy
```

## The Terraform workflow explained

1. `terraform init` — downloads the cloud provider plugin
2. `terraform plan` — shows exactly what will be created, changed, or destroyed before touching anything
3. `terraform apply` — builds the infrastructure from the config file
4. `terraform destroy` — cleanly removes everything, no leftover resources

## What I'd add next

- A VPC and EC2 instance to run a web application on the provisioned infrastructure
- Remote state storage using an S3 backend so state files are shared safely across a team
- Separate environments (dev/staging/prod) using Terraform workspaces
- GitHub Actions pipeline to automatically plan on pull requests and apply on merge to main
