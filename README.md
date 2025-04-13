# Azure Ubuntu VM Deployment with Terraform

This repository demonstrates the deployment of a secure, lightweight **Ubuntu Linux Virtual Machine (Ubuntu 22.04 LTS)** in **Microsoft Azure**, using **Terraform** as an Infrastructure-as-Code (IaC) tool. The configuration reflects a production-conscious mindset, enforcing secure SSH authentication, structured networking, and resilience against platform-level restrictions.

---

## 🛠️ Project Objectives

- Provision a Linux VM in the `West US` Azure region
- Enable secure public SSH access using a static IP
- Automate networking components: VNet, Subnet, Route Table, NSG
- Leverage reusable and maintainable Terraform code structure
- Solve real-world deployment constraints (covered below)

---

## 📁 Project Structure

| File                  | Purpose |
|-----------------------|---------|
| `main.tf`             | Defines the VM and core networking resources |
| `networking.tf`       | Contains VNet, Subnet, Route Table, and associations |
| `resources-group.tf`  | Creates the Azure Resource Group |
| `provider.tf`         | Declares Terraform provider setup |
| `README.md`           | Documentation and project guidance |

---

## ⚠️ Deployment Challenges & Workarounds

### ❌ Challenge 1: Azure Policy Blocked Premium SKUs

**Issue**: The Azure subscription had a policy that **prevented the use of Premium SKUs** (e.g., `Premium_LRS`, certain VM sizes).

**Solution**: We explicitly selected **Standard SKUs** compatible with the policy:
```hcl
os_disk {
  storage_account_type = "Standard_LRS"
}
size = "Standard_B2s"

### ❌ Challenge 2: Resource Creation was Blocked by Policy

**Issue**: A restrictive policy prevented Terraform from creating certain resources.

**Solution**: We used the terraform import command to bring existing Azure resources under Terraform management. This allowed us to:

Preserve infrastructure already in place

Continue using Terraform for change management

Comply with enterprise governance constraints


🔐 Security Considerations
Password login is disabled (disable_password_authentication = true)

SSH public key authentication is enforced

NSG restricts inbound traffic to port 22 only


This project exemplifies:

Using Terraform effectively in enterprise Azure environments

Adapting to constraints like policy-enforced governance

Secure, minimal virtual machine provisioning

Production-grade network design fundamentals
