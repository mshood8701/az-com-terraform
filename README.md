Deploying a Secure Ubuntu VM on Azure Using Terraform
This repository outlines the structured deployment of a Ubuntu 22.04 LTS Virtual Machine in Microsoft Azure, leveraging Terraform as an Infrastructure-as-Code (IaC) solution. The approach emphasizes security, simplicity, and operational readiness, in line with best practices for enterprise-grade environments. Key infrastructure components are explicitly defined, ensuring transparency, reusability, and adaptability in the face of cloud policy constraints.

Project Goals
Deploy a Linux VM within the West US Azure region

Enforce secure SSH access via static public IP

Automate key networking resources: Virtual Network, Subnet, Route Table, and Network Security Group

Maintain clean, modular Terraform configurations for long-term manageability

Address practical deployment limitations commonly found in policy-restricted enterprise environments

