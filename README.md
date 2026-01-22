# Terraform 3-Tier Architecture on AWS

## 📌 Project Overview

This project demonstrates a **production-style 3-tier architecture on AWS** provisioned entirely using **Terraform (Infrastructure as Code)**.

The architecture follows industry best practices by separating the **Web**, **Application**, and **Database** layers across **public and private subnets**, ensuring security, scalability, and maintainability.

---

## 🏗️ Architecture Overview

### 3-Tier Design

![alt](/images/architecture-diagram.png)

### Network Segmentation

| Layer    | Subnet Type | Internet Access |
| -------- | ----------- | --------------- |
| Web      | Public      | Direct via IGW  |
| App      | Private     | Via NAT Gateway |
| Database | Private     | No Internet     |

---

## 📂 Project Structure

```
terraform-3tier-architecture/
│
├── main.tf                # Root module
├── variables.tf           # Input variables
├── outputs.tf             # Output values
├── provider.tf            # AWS provider configuration
├── terraform.tfvars       # Variable values
│
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── web_ec2/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── app_ec2/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── rds/
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       ├── security_group.tf
│       └── subnet_group.tf
│
└── README.md
```

---

## 🔐 Security Design

### Security Groups

* **Web EC2 SG**

  * Allows HTTP (80) from `0.0.0.0/0`
  * Allows SSH from admin IP

* **App EC2 SG**

  * Allows traffic only from Web EC2 SG
  * No public internet access

* **RDS SG**

  * Allows MySQL (3306) only from App EC2 SG
  * Fully isolated in private subnet

This follows the **principle of least privilege**.

---

## 🧱 Infrastructure Components

### VPC

* Custom VPC
* DNS support enabled
* Public & private subnets

### EC2 Instances

* Web tier in public subnet
* App tier in private subnet
* Configurable instance types via variables

### RDS (MySQL)

* Multi-AZ enabled
* Private subnet only
* No public access

---

## ⚙️ Terraform Features Used

* **Modules for reusability**  
      Infrastructure is split into reusable Terraform modules (VPC, Web EC2, App EC2, RDS). This improves code organization, avoids duplication, and reflects how infrastructure is managed in real DevOps teams.

* **Variables & outputs**  
     Input variables are used to make the infrastructure configurable (instance types, CIDR blocks, credentials), while outputs expose important values such as resource IDs and endpoints for cross-module usage.

* **Resource dependencies**  
      Terraform automatically manages resource creation order based on references (for example, EC2 instances depend on subnets and security groups). This ensures reliable and predictable infrastructure provisioning.

* **Security group referencing**  
      Security groups reference other security groups instead of CIDR blocks, allowing controlled communication between tiers (Web → App → Database) and enforcing least-privilege access.

* **Subnet groups for RDS**  
      An RDS subnet group is used to explicitly place the database in private subnets only, ensuring the database is isolated from the public internet and aligned with AWS security best practices.

---

## 🚀 How to Deploy

### Prerequisites

* AWS account
* Terraform
* AWS CLI configured (`aws configure`)

### Steps

```bash
terraform init
terraform validate
terraform plan
terraform apply
```

Confirm with `yes` when prompted.

## 🧹 Cleanup

To destroy all resources:

```bash
terraform destroy
```

---

## ⚠️ Important Notes

* **Do NOT commit `terraform.tfstate` files**
* This project is for learning purposes
* For production, use:

  * Remote backend (S3 + DynamoDB)
  * NAT Gateway
  * Secrets Manager for DB credentials

---

## 📈 Future Improvements

* Add remote backend (S3 + DynamoDB)
* Implement ALB instead of direct EC2 access
* Auto Scaling Groups
* CI/CD integration

---

## 👤 Author

Built by **Kenish** as a hands-on Terraform & AWS learning project.

---

