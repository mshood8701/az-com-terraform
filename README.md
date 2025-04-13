Deploying a Secure Ubuntu VM on Azure with Terraform
This repository outlines a production-conscious deployment of an Ubuntu 22.04 LTS Virtual Machine on Microsoft Azure, using Terraform for Infrastructure-as-Code (IaC). The configuration prioritizes security, modularity, and compliance with Azure enterprise governance.

Key Objectives
Deploy a Linux VM in Azure’s West US region

Enable secure SSH access using a static public IP

Automate creation of VNet, Subnet, Route Table, and NSG

Use a clean, reusable Terraform codebase

Address real-world policy constraints
Project Structure

| File                  | Purpose |
|-----------------------|---------|
| `main.tf`             | Defines the VM and core networking resources |
| `networking.tf`       | Contains VNet, Subnet, Route Table, and associations |
| `resources-group.tf`  | Creates the Azure Resource Group |
| `provider.tf`         | Declares Terraform provider setup |
| `README.md`           | Documentation and project guidance |


Challenge 1: Azure Policy Restricting Premium SKUs
Issue: Subscription disallowed use of Premium_LRS and certain VM sizes

Solution: Used Standard_LRS for disk type and Standard_B2s for VM size

Challenge 2: Restricted Resource Creation
Issue: Policy blocked Terraform from provisioning resources group as it is a managed platform

Solution: Used terraform import to manage existing infrastructure

Ensured policy compliance

Maintained Terraform’s benefits for future change control


Security Best Practices Implemented
SSH key-based access only (password authentication disabled)

NSG limits inbound traffic to port 22 (SSH only)

Minimal, secure VM footprint


This project demonstrates:

Secure and compliant VM provisioning with Terraform

Adaptability to Azure policy constraints

Production-level networking and infrastructure standards

A traditional, disciplined approach to cloud automation and security

