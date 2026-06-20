Basic AWS Infrastructure with Terraform

This is a simple DevOps project where I used Terraform to create basic AWS infrastructure.

The goal of this project is to understand Infrastructure as Code by creating an EC2 instance, configuring a Security Group, installing Docker automatically using EC2 user data, and running an Nginx container.

This project helped me understand how cloud infrastructure can be created, changed, and destroyed using code instead of manually clicking in the AWS Console.

---

## Tools Used

* Terraform
* AWS
* AWS CLI
* EC2
* Security Group
* Docker
* Nginx
* VS Code
* Git/GitHub

---

## Architecture

```text
Developer writes Terraform code
→ terraform init downloads the AWS provider
→ terraform plan previews the infrastructure
→ terraform apply creates AWS resources
→ EC2 instance starts
→ user_data installs Docker
→ Docker runs Nginx container
→ user opens the public IP in browser
→ terraform destroy removes the resources
```

Simple architecture:

```text
AWS Cloud
│
└── Default VPC
    │
    ├── Security Group
    │   └── Allows HTTP traffic on port 80
    │
    └── EC2 Instance
        ├── Amazon Linux
        ├── Docker installed automatically
        └── Nginx container running on port 80
```

---

## Folder Structure

```text
devops-terraform-aws-basic/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── user_data.sh
├── .gitignore
└── README.md
```

### File Explanation

| File           | Purpose                                                             |
| -------------- | ------------------------------------------------------------------- |
| `versions.tf`  | Defines Terraform and AWS provider requirements                     |
| `variables.tf` | Stores reusable values like region, project name, and instance type |
| `main.tf`      | Contains the main AWS infrastructure code                           |
| `outputs.tf`   | Prints useful values such as EC2 public IP and website URL          |
| `user_data.sh` | Installs Docker and runs Nginx when EC2 starts                      |
| `.gitignore`   | Prevents Terraform state and sensitive files from being pushed      |
| `README.md`    | Project documentation                                               |

---

## Prerequisites

Before running this project, the following tools should be installed:

```bash
aws --version
terraform version
```

You also need an AWS account and AWS CLI configured.

Configure AWS CLI:

```bash
aws configure
```

Verify AWS credentials:

```bash
aws sts get-caller-identity
```

---

## Terraform Commands

### 1. Initialize Terraform

```bash
terraform init
```

This downloads the AWS provider required by Terraform.

---

### 2. Format Terraform Code

```bash
terraform fmt
```

This formats Terraform files properly.

---

### 3. Validate Terraform Code

```bash
terraform validate
```

This checks whether the Terraform configuration is valid.

---

### 4. Preview Infrastructure

```bash
terraform plan
```

This shows what Terraform will create before actually creating anything.

---

### 5. Create Infrastructure

```bash
terraform apply
```

Type:

```text
yes
```

Terraform will create:

```text
EC2 instance
Security Group
```

---

### 6. View Outputs

```bash
terraform output
```

Example output:

```text
instance_id = "i-xxxxxxxxxxxxxxxxx"
public_ip = "xx.xx.xx.xx"
website_url = "http://xx.xx.xx.xx"
```

---

### 7. Test the Website

Open the `website_url` in your browser.

Or test using curl:

```bash
curl http://<public-ip>
```

Expected result:

```text
Nginx welcome page
```

---

### 8. Destroy Infrastructure

After testing, destroy the resources to avoid unnecessary AWS costs:

```bash
terraform destroy
```

Type:

```text
yes
```

---

## Common Issues Faced

### AWS Credentials Not Configured

Error:

```text
No valid credential sources found
```

Fix:

```bash
aws configure
aws sts get-caller-identity
```

---

### Wrong AWS Region

Sometimes resources are created successfully, but they are not visible in the AWS Console because the wrong region is selected.

Check the region in `variables.tf`.

Example:

```hcl
default = "ap-south-1"
```

Then make sure the AWS Console is also opened in the same region.

---

### Default VPC Not Found

Error:

```text
no matching EC2 VPC found
```

Possible fix:

```text
Use another AWS region where the default VPC exists
or create a custom VPC later using Terraform
```

---

### Website Not Opening

Possible reasons:

```text
EC2 instance is still starting
Docker installation is not complete
Security Group does not allow port 80
Wrong public IP is being used
Nginx container failed to start
```

Useful checks:

```bash
terraform output public_ip
curl http://<public-ip>
```

---
