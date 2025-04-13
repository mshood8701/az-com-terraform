###🚀 Deploying a Secure Ubuntu VM on Azure Using Terraform
This repository outlines the structured deployment of a Ubuntu 22.04 LTS Virtual Machine in Microsoft Azure, leveraging Terraform as an Infrastructure-as-Code (IaC) solution. The approach emphasizes security, simplicity, and operational readiness, in line with best practices for enterprise-grade environments. Key infrastructure components are explicitly defined, ensuring transparency, reusability, and adaptability in the face of cloud policy constraints.

##🧭 Project Goals
Deploy a Linux VM within the West US Azure region

Enforce secure SSH access via static public IP

Automate key networking resources: Virtual Network, Subnet, Route Table, and Network Security Group

Maintain clean, modular Terraform configurations for long-term manageability

Address practical deployment limitations commonly found in policy-restricted enterprise environments

##📂 Repository Overview
| File                  | Purpose |
|-----------------------|---------|
| `main.tf`             | Defines the VM and core networking resources |
| `networking.tf`       | Contains VNet, Subnet, Route Table, and associations |
| `resources-group.tf`  | Creates the Azure Resource Group |
| `provider.tf`         | Declares Terraform provider setup |
| `README.md`           | Documentation and project guidance |

##⚠️ Known Challenges & Mitigation Strategies
❌ Policy Restriction: Premium SKUs Blocked
Issue: The Azure subscription enforces a policy preventing use of Premium SKUs (e.g., Premium_LRS, high-performance VM sizes).

Approach:

hcl
os_disk {
  storage_account_type = "Standard_LRS"
}
size = "Standard_B2s"
By explicitly choosing Standard-tier configurations, the deployment remains compliant without sacrificing core functionality.

❌ Policy Restriction: Resource Creation Denied
Issue: Some Terraform-created resources were rejected due to policy constraints.

Workaround: Where resource creation was blocked, we used the terraform import command to incorporate pre-existing infrastructure into the Terraform state. This allowed for:

Continued use of Terraform for state tracking and change management

Adherence to existing governance rules

Preservation of operational continuity

##🔐 Security-First Configuration
Password authentication is disabled:
disable_password_authentication = true

SSH access is restricted to public key authentication only

NSG limits inbound traffic strictly to port 22

##✅ This project examplifies:
This deployment showcases how Terraform can be harnessed effectively in real-world, policy-bound Azure environments. It reflects a pragmatic approach to:

Navigating enterprise cloud governance

Enforcing baseline security and operational discipline

Structuring IaC for maintainability and clarity

Building resilient, minimal infrastructure without overreach

