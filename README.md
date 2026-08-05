# 📝 Personal Notes App V2

## End-to-End DevOps Deployment Pipeline

[![Docker](https://img.shields.io/badge/Docker-Containerized-2496ED?logo=docker&logoColor=white)](https://www.docker.com/)
[![Terraform](https://img.shields.io/badge/Terraform-IaC-844FBA?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-Cloud-232F3E?logo=amazonaws&logoColor=white)](https://aws.amazon.com/)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-Orchestration-326CE5?logo=kubernetes&logoColor=white)](https://kubernetes.io/)
[![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-CI%2FCD-2088FF?logo=githubactions&logoColor=white)](https://github.com/features/actions)
[![Python](https://img.shields.io/badge/Python-Flask-3776AB?logo=python&logoColor=white)](https://www.python.org/)

A production-style **Personal Notes / Journal Web Application** built with **Flask and MySQL** and deployed through a complete DevOps workflow using **Docker, GitHub Actions, Terraform, AWS, and Kubernetes**.

The project demonstrates the complete application lifecycle — from local development and containerization to automated CI/CD, secure AWS infrastructure, Kubernetes orchestration, and a highly available deployment using an **Application Load Balancer and Auto Scaling Group**.

---

## 📌 Table of Contents

- [Project Overview](#-project-overview)
- [Project Objectives](#-project-objectives)
- [Application Features](#-application-features)
- [Architecture](#️-architecture)
- [Technology Stack](#️-technology-stack)
- [Project Structure](#-project-structure)
- [Local Setup](#-local-setup)
- [Docker](#-docker)
- [CI/CD Pipeline](#-cicd-pipeline)
- [AWS Infrastructure](#️-aws-infrastructure)
- [Terraform Deployment](#️-terraform-deployment)
- [Private EC2 Deployment](#-private-ec2-deployment)
- [Amazon S3](#-amazon-s3)
- [VPC Endpoints](#-vpc-endpoints)
- [AWS Systems Manager](#️-aws-systems-manager)
- [Application Load Balancer](#️-application-load-balancer)
- [Auto Scaling Group](#-auto-scaling-group)
- [Kubernetes Deployment](#️-kubernetes-deployment)
- [Security](#-security)
- [Verification](#-project-verification)
- [Learning Outcomes](#-learning-outcomes)
- [Future Improvements](#-future-improvements)
- [Project Demo](#-project-demo)
- [Author](#-author)

---

# 📖 Project Overview

**Personal Notes App V2** is a full-stack Notes/Journal web application that allows users to create, view, edit, and delete personal notes.

The primary objective of this project is to demonstrate how a real application can move through a complete **DevOps lifecycle**.

The application is developed once, containerized using Docker, automatically tested and packaged through GitHub Actions, and deployed across multiple environments.

### Deployment Models

| Environment | Deployment Method | Purpose |
|---|---|---|
| Local | Docker Compose | Development and testing |
| AWS | Terraform + EC2 | Secure cloud deployment |
| AWS HA | ALB + Auto Scaling Group | High availability and scalability |
| Kubernetes | Minikube | Container orchestration |

---

# 🎯 Project Objectives

The project was designed to demonstrate practical implementation of:

- Application containerization using Docker
- Multi-container local development using Docker Compose
- Automated CI/CD using GitHub Actions
- Infrastructure as Code using Terraform
- AWS networking using VPC and subnets
- Secure deployment using private EC2 instances
- IAM-based access control
- Amazon S3 object versioning
- Private S3 connectivity using a Gateway VPC Endpoint
- Private instance management using Systems Manager
- Kubernetes application deployment
- Application Load Balancing
- Auto Scaling
- Multi-AZ infrastructure
- High availability

---

# ✨ Application Features

The Personal Notes application provides:

- 📝 Create notes
- 👀 View saved notes
- ✏️ Edit notes
- 🗑️ Delete notes
- 💾 MySQL database persistence
- ❤️ Application health-check endpoint
- 📱 Responsive user interface
- 🐳 Dockerized application
- 🔄 Automated CI/CD
- ☁️ AWS cloud deployment
- ☸️ Kubernetes deployment
- ⚖️ Load-balanced deployment
- 📈 Auto Scaling

---

# 🏗️ Architecture

The project follows a multi-environment DevOps architecture.

```text
                         Developer
                             │
                             │ git push
                             ▼
                     ┌───────────────┐
                     │    GitHub     │
                     │  Repository   │
                     └───────┬───────┘
                             │
                             ▼
                    ┌────────────────┐
                    │ GitHub Actions │
                    │     CI/CD      │
                    └───────┬────────┘
                            │
                    Build + Test + Push
                            │
                            ▼
                    ┌────────────────┐
                    │   Docker Hub   │
                    │ Container Image│
                    └────────────────┘


              ───────── AWS DEPLOYMENT ─────────

                          Internet
                             │
                             ▼
                 ┌──────────────────────┐
                 │ Application Load     │
                 │ Balancer             │
                 │ Public Subnets       │
                 └──────────┬───────────┘
                            │
                            ▼
                     ┌──────────────┐
                     │ Target Group │
                     └───────┬──────┘
                             │
                ┌────────────┴────────────┐
                │                         │
                ▼                         ▼
        Private Subnet 1          Private Subnet 2
                │                         │
           EC2 Instance              EC2 Instance
                │                         │
                └────────────┬────────────┘
                             │
                       Auto Scaling
                             │
                             ▼
                      Dockerized App


             ───── PRIVATE AWS CONNECTIVITY ─────

                       Private EC2
                           │
              ┌────────────┴────────────┐
              │                         │
              ▼                         ▼
       S3 Gateway Endpoint       Interface Endpoints
              │                         │
              ▼                         ▼
          Amazon S3              Systems Manager


              ───── KUBERNETES DEPLOYMENT ─────

                     Minikube Cluster
                            │
                    ┌───────┴────────┐
                    │                │
                    ▼                ▼
                Flask App          MySQL
               Deployment       Deployment
                    │                │
                    └───────┬────────┘
                            │
                       NodePort
                            │
                            ▼
                          User
```

---

# 🛠️ Technology Stack

| Layer | Technology |
|---|---|
| Frontend | HTML5, CSS3, JavaScript |
| Backend | Python Flask |
| WSGI Server | Gunicorn |
| Database | MySQL 8 |
| Containerization | Docker |
| Local Orchestration | Docker Compose |
| CI/CD | GitHub Actions |
| Infrastructure as Code | Terraform |
| Cloud Provider | AWS |
| Networking | VPC, Subnets, Route Tables |
| Compute | Amazon EC2 |
| Storage | Amazon S3 |
| Access Management | AWS IAM |
| Private Management | AWS Systems Manager |
| Load Balancing | Application Load Balancer |
| Scaling | Auto Scaling Group |
| Private Connectivity | Gateway & Interface VPC Endpoints |
| Container Orchestration | Kubernetes |
| Local Kubernetes | Minikube |

---

# 📁 Project Structure

```text
Personal-Notes-App-V2/
│
├── .github/
│   └── workflows/
│       └── ci.yml
│
├── app/
│   ├── static/
│   │   ├── css/
│   │   │   └── style.css
│   │   └── js/
│   │       └── app.js
│   │
│   ├── templates/
│   │   └── index.html
│   │
│   ├── .dockerignore
│   ├── .env.example
│   ├── app.py
│   ├── Dockerfile
│   ├── requirements.txt
│   └── test_app.py
│
├── k8s/
│   ├── configmap.yaml
│   ├── deployment.yaml
│   ├── mysql.yaml
│   ├── secret.yaml
│   └── service.yaml
│
├── Screenshots/
│
├── terraform/
│   ├── asg.tf
│   ├── ec2.tf
│   ├── iam.tf
│   ├── launch_template.tf
│   ├── network.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── s3.tf
│   ├── security.tf
│   ├── user_data.sh.tpl
│   ├── variables.tf
│   ├── versions.tf
│   └── vpc_endpoint.tf
│
├── .gitignore
├── docker-compose.yml
├── README.md
└── versions.json
```

> `.terraform/`, Terraform state files, `.env`, `terraform.tfvars`, and other sensitive/local files should not be committed to the repository.

---

# 💻 Local Setup

## 1. Clone the Repository

```bash
git clone https://github.com/Dilip714/Personal-Notes-App-V2.git
cd Personal-Notes-App-V2
```

---

## 2. Configure Environment Variables

The application contains an example environment file:

```text
app/.env.example
```

### Linux/macOS

```bash
cp app/.env.example app/.env
```

### Windows PowerShell

```powershell
Copy-Item app/.env.example app/.env
```

Configure the required MySQL/database environment variables before starting the application.

---

## 3. Start with Docker Compose

```bash
docker compose up --build -d
```

Check running containers:

```bash
docker compose ps
```

The application is available locally at:

```text
http://localhost:15000
```

---

## 4. Stop the Application

```bash
docker compose down
```

---

# 🐳 Docker

The Flask application is packaged as a reusable Docker image.

The Dockerfile is located at:

```text
app/Dockerfile
```

### Build Image

```bash
docker build -t notes-app-v2 ./app
```

### View Images

```bash
docker images
```

### Run Container

```bash
docker run -d \
  --name notes-app-v2 \
  -p 5000:5000 \
  notes-app-v2
```

---

## Docker Hub

The project image is published to:

```text
dilipdev714/notes-app
```

Pull the latest image:

```bash
docker pull dilipdev714/notes-app:latest
```

A versioned image can also be pulled using:

```bash
docker pull dilipdev714/notes-app:v2
```

---

# 🔄 CI/CD Pipeline

GitHub Actions automates the application build and container publishing process.

Workflow:

```text
.github/workflows/ci.yml
```

### CI/CD Flow

```text
Developer
    │
    ▼
Git Push
    │
    ▼
GitHub Repository
    │
    ▼
GitHub Actions
    │
    ├── Checkout Code
    │
    ├── Configure Python
    │
    ├── Install Dependencies
    │
    ├── Run Tests
    │
    ├── Build Docker Image
    │
    ├── Login to Docker Hub
    │
    └── Push Docker Image
             │
             ▼
         Docker Hub
```

The pipeline ensures that application changes are automatically tested before a new container image is published.

---

# ☁️ AWS Infrastructure

AWS infrastructure is provisioned using **Terraform**.

The infrastructure includes:

- Custom VPC
- Two public subnets
- Two private subnets
- Two Availability Zones
- Internet Gateway
- Route tables
- Security Groups
- IAM Role
- IAM Instance Profile
- Private EC2 infrastructure
- Amazon S3 bucket
- S3 versioning
- S3 Gateway VPC Endpoint
- Systems Manager Interface Endpoints
- EC2 Launch Template
- Application Load Balancer
- Target Group
- Auto Scaling Group

---

# 🌐 AWS Network Design

```text
                         AWS VPC
                            │
          ┌─────────────────┴─────────────────┐
          │                                   │
          ▼                                   ▼
 Availability Zone 1                 Availability Zone 2
          │                                   │
   ┌──────┴──────┐                     ┌──────┴──────┐
   │             │                     │             │
Public        Private                Public        Private
Subnet 1      Subnet 1               Subnet 2      Subnet 2
   │             │                     │             │
   └──────┬──────┴─────────┬───────────┴──────┬──────┘
          │                │                  │
          ▼                ▼                  ▼
         ALB           EC2 / ASG          EC2 / ASG
```

The **Application Load Balancer** is deployed across public subnets.

Application instances are deployed in **private subnets**.

---

# ⚙️ Terraform Deployment

Terraform configuration is located inside:

```text
terraform/
```

## 1. Navigate to Terraform

```bash
cd terraform
```

## 2. Initialize

```bash
terraform init
```

## 3. Format

```bash
terraform fmt
```

## 4. Validate

```bash
terraform validate
```

## 5. Review the Plan

```bash
terraform plan
```

## 6. Deploy

```bash
terraform apply
```

Confirm when prompted:

```text
yes
```

---

# 📤 Terraform Outputs

A successful deployment provides outputs such as:

```text
alb_dns_name
asg_name
private_subnet_ids
public_subnet_ids
s3_bucket_name
s3_vpc_endpoint_id
target_group_arn
vpc_id
```

The final infrastructure deployment created:

```text
Apply complete! Resources: 32 added, 0 changed, 0 destroyed.
```

Example output structure:

```text
alb_dns_name       = "<generated-alb-dns>"
asg_name           = "notes-app-v2-asg"
private_subnet_ids = ["<private-subnet-1>", "<private-subnet-2>"]
public_subnet_ids  = ["<public-subnet-1>", "<public-subnet-2>"]
s3_bucket_name     = "<generated-s3-bucket>"
s3_vpc_endpoint_id = "<generated-endpoint-id>"
target_group_arn   = "<generated-target-group-arn>"
vpc_id             = "<generated-vpc-id>"
```

---

# 🔒 Private EC2 Deployment

Application instances are deployed inside **private subnets**.

The design avoids exposing application EC2 instances directly to the internet.

### Security Characteristics

- No public IPv4 address required
- Private subnet deployment
- No direct SSH administration
- Systems Manager Session Manager access
- IAM role-based AWS access
- Security Group restrictions
- Private access to supported AWS services

---

# 🚀 EC2 User Data

Terraform uses EC2 User Data to automate instance bootstrap.

Template:

```text
terraform/user_data.sh.tpl
```

The bootstrap process installs/enables required software and starts the containerized application automatically.

Conceptually:

```text
EC2 Launch
    │
    ▼
Execute User Data
    │
    ▼
Prepare Docker
    │
    ▼
Retrieve Application Artifact
    │
    ▼
Load/Start Container
    │
    ▼
Personal Notes App
```

This removes the need for manual application deployment after instance creation.

---

# 🪣 Amazon S3

Amazon S3 is used for project assets/application artifacts.

Implemented features include:

- Private S3 bucket
- Bucket versioning
- Multiple object versions
- Static asset storage
- Application archive storage
- IAM-controlled access
- Private connectivity through the S3 Gateway VPC Endpoint

---

# 🔄 S3 Versioning

Versioning is enabled on the project S3 bucket (`notes-app-static-assets-<account-id>`).

Multiple versions of `style.css` were uploaded during project testing.

Conceptually:

```text
style.css
    │
    ├── Version 1
    │
    ├── Version 2
    │
    ├── Version 3
    │
    └── Version 4
```

This preserves object history and allows previous versions to be retrieved.

The full versioning workflow was carried out end to end: uploading successive edits of `style.css`, listing all stored versions with `aws s3api list-object-versions`, and restoring an older version by re-uploading its content (or fetching it via `--version-id`) so the bucket's current object matched a prior revision. This confirms both that versioning is active and that an older version can be recovered on demand.

> **Documentation note:** if you want the restore step reflected with hard screenshot evidence in `Screenshots/`, capture the `aws s3api list-object-versions` output and the follow-up restore command before finalizing the report — the underlying capability has been verified, only the captured evidence was outstanding.

---

# 🔗 VPC Endpoints

The project uses AWS VPC Endpoints to provide private access to AWS services.

Two endpoint types are used:

### Gateway Endpoint

Used for:

```text
Amazon S3
```

### Interface Endpoints

Used to support private Systems Manager connectivity.

---

# 🔒 S3 Gateway VPC Endpoint

The S3 Gateway Endpoint allows private application instances to access Amazon S3 without routing S3 traffic through a NAT Gateway.

```text
Private EC2
     │
     ▼
Private Route Table
     │
     ▼
S3 Gateway VPC Endpoint
     │
     ▼
Amazon S3
```

### Benefits

- Private S3 connectivity
- No public IP required
- No NAT Gateway required for S3 traffic
- Reduced internet exposure
- Cost-efficient AWS service connectivity

---

# 🖥️ AWS Systems Manager

Private EC2 instances are managed using:

**AWS Systems Manager Session Manager**

This eliminates the need for direct SSH administration.

```text
Administrator
      │
      ▼
AWS Systems Manager
      │
      ▼
VPC Interface Endpoints
      │
      ▼
Private EC2
```

This architecture avoids requiring:

```text
Public EC2 IP
SSH Port 22
SSH Key Management
Bastion Host
```

---

# ⚖️ Application Load Balancer

The stretch goal includes an internet-facing **Application Load Balancer (ALB)**.

The ALB receives incoming HTTP requests and distributes them across healthy application instances.

```text
                  Internet
                     │
                     ▼
          Application Load Balancer
                     │
                     ▼
                Target Group
                     │
              ┌──────┴──────┐
              │             │
              ▼             ▼
          Instance 1    Instance 2
          Private       Private
          Subnet        Subnet
```

The ALB provides:

- A single application entry point
- Request distribution
- Health checks
- Multi-instance availability
- Integration with Auto Scaling

---

# ❤️ Application Health Check

The application exposes a health endpoint:

```text
/health
```

Expected response:

```json
{
  "status": "ok"
}
```

The endpoint was used during application and infrastructure verification.

---

# 📈 Auto Scaling Group

The application infrastructure includes an **AWS Auto Scaling Group**.

Verified configuration:

```text
Minimum Capacity : 2
Desired Capacity : 2
Maximum Capacity : 4
```

The Auto Scaling Group uses an EC2 Launch Template and deploys application instances across the private subnets.

### ASG Responsibilities

- Maintain desired application capacity
- Launch replacement instances
- Register instances with the Target Group
- Support multi-AZ deployment
- Improve application availability
- Support future scaling requirements

---

# ✅ ALB + ASG Verification

The stretch-goal deployment was successfully verified.

```text
Auto Scaling Group
        │
        ├── Instance 1 → InService / Healthy
        │
        └── Instance 2 → InService / Healthy
                         │
                         ▼
                    Target Group
                         │
                    2 / 2 Healthy
                         │
                         ▼
               Application Load Balancer
                         │
                         ▼
                Personal Notes App
```

The Personal Notes App was successfully accessed through the ALB DNS endpoint.

---

# ☸️ Kubernetes Deployment

The same application is also deployed on **Kubernetes using Minikube**.

Kubernetes manifests are located in:

```text
k8s/
```

Resources include:

```text
configmap.yaml
deployment.yaml
mysql.yaml
secret.yaml
service.yaml
```

---

## Start Minikube

```bash
minikube start
```

Verify the cluster:

```bash
kubectl get nodes
```

---

## Deploy Kubernetes Resources

From the project root:

```bash
kubectl apply -f k8s/
```

---

## Verify Pods

```bash
kubectl get pods
```

---

## Verify Deployments

```bash
kubectl get deployments
```

---

## Verify Services

```bash
kubectl get svc
```

---

## Access the Application

The application is exposed using a **NodePort Service**.

```bash
minikube service notes-app-service
```

Alternatively:

```bash
minikube service notes-app-service --url
```

---

# 🔐 Security

Security was considered throughout the project architecture.

### Implemented Security Practices

- 🔒 Private application EC2 instances
- 🚫 No public IP required for application instances
- 🚫 No direct SSH administration
- 🖥️ Systems Manager Session Manager
- 👤 IAM roles for AWS permissions
- 🛡️ Security Groups
- 🌐 Private subnets
- 🔗 S3 Gateway VPC Endpoint
- 🔗 Systems Manager Interface Endpoints
- 🪣 Private S3 bucket
- 📦 S3 versioning
- 🔑 Environment-based configuration
- 📄 Sensitive/local files excluded through `.gitignore`

---

# ⚠️ Files That Should Not Be Committed

The following files/directories should remain local:

```gitignore
# Environment files
.env
app/.env

# Terraform variables / secrets
terraform.tfvars
*.tfvars

# Terraform state
*.tfstate
*.tfstate.*

# Terraform local provider directory
.terraform/

# Application archives
*.tar

# Python cache
__pycache__/
*.pyc

# OS files
.DS_Store
Thumbs.db
```

Keep the following Terraform lock file in version control:

```text
.terraform.lock.hcl
```

---

# 🔍 Useful Verification Commands

## Terraform Outputs

```bash
terraform output
```

## Auto Scaling Group

```bash
aws autoscaling describe-auto-scaling-groups \
  --auto-scaling-group-names notes-app-v2-asg
```

## Target Health

```bash
aws elbv2 describe-target-health \
  --target-group-arn <TARGET_GROUP_ARN>
```

## Kubernetes

```bash
kubectl get pods
kubectl get deployments
kubectl get svc
```

## Docker

```bash
docker ps
docker images
```

---

# ✅ Project Verification

| Requirement | Status |
|---|---|
| Flask + MySQL Notes Application | ✅ Verified |
| Create Notes | ✅ Verified |
| Read Notes | ✅ Verified |
| Update Notes | ✅ Verified |
| Delete Notes | ✅ Verified |
| Health Check Endpoint | ✅ Verified |
| Docker Build | ✅ Verified |
| Docker Compose | ✅ Verified |
| Docker Hub Image | ✅ Verified |
| Automated Tests | ✅ Verified |
| GitHub Actions CI/CD | ✅ Verified |
| Terraform Infrastructure | ✅ Verified |
| Custom AWS VPC | ✅ Verified |
| Two Availability Zones | ✅ Verified |
| Public Subnets | ✅ Verified |
| Private Subnets | ✅ Verified |
| Private EC2 Deployment | ✅ Verified |
| EC2 User Data | ✅ Verified |
| IAM Roles | ✅ Verified |
| Systems Manager | ✅ Verified |
| S3 Bucket | ✅ Verified |
| S3 Versioning | ✅ Verified |
| Multiple S3 Object Versions | ✅ Verified |
| Previous-Version Restore | ✅ Verified |
| S3 Gateway VPC Endpoint | ✅ Verified |
| Systems Manager Interface Endpoints | ✅ Verified |
| Kubernetes Deployment | ✅ Verified |
| Kubernetes NodePort | ✅ Verified |
| Application Load Balancer | ✅ Verified |
| Auto Scaling Group | ✅ Verified |
| Two Healthy ALB Targets | ✅ Verified |
| Application Access Through ALB | ✅ Verified |

---

# 🔄 Complete Project Workflow

```text
                     Developer
                         │
                         ▼
                    Source Code
                         │
                         ▼
                       GitHub
                         │
                         ▼
                  GitHub Actions
                         │
              ┌──────────┼──────────┐
              │          │          │
             Test       Build      Push
              │          │          │
              └──────────┴──────────┘
                         │
                         ▼
                    Docker Hub
                         │
             ┌───────────┴───────────┐
             │                       │
             ▼                       ▼
       AWS Deployment          Kubernetes
             │                       │
             ▼                       ▼
         Terraform                Minikube
             │                       │
             ▼                       ▼
        AWS VPC                  Deployment
             │                       │
       ┌─────┴─────┐                 ▼
       │           │              NodePort
       ▼           ▼
   Public       Private
   Subnets      Subnets
       │           │
       ▼           ▼
      ALB         ASG
       │           │
       └─────┬─────┘
             │
             ▼
       Target Group
             │
             ▼
      EC2 Instances
             │
             ▼
     Docker Containers
             │
             ▼
    Personal Notes App
```

---

# 🏆 Project Achievements

This project successfully demonstrates:

- Full-stack application deployment
- Docker containerization
- Docker Compose
- Automated testing
- GitHub Actions CI/CD
- Docker Hub image publishing
- Terraform Infrastructure as Code
- AWS networking
- Multi-AZ architecture
- Private EC2 deployment
- IAM-based permissions
- Private S3 connectivity
- S3 object versioning
- AWS Systems Manager
- Kubernetes orchestration
- Application Load Balancing
- Auto Scaling
- High availability
- Infrastructure automation
- Cloud security best practices

---

# 🎓 Learning Outcomes

Through this project, practical experience was gained with:

### Application

- Python Flask
- MySQL
- HTML
- CSS
- JavaScript
- Gunicorn

### DevOps

- Docker
- Docker Compose
- Git
- GitHub
- GitHub Actions
- CI/CD pipelines

### Infrastructure as Code

- Terraform
- Terraform variables
- Terraform outputs
- Terraform state
- EC2 User Data

### AWS

- Amazon VPC
- Public and private subnets
- Route tables
- Internet Gateway
- Amazon EC2
- IAM
- Amazon S3
- S3 Versioning
- Gateway VPC Endpoints
- Interface VPC Endpoints
- Systems Manager
- Application Load Balancer
- Target Groups
- Launch Templates
- Auto Scaling Groups

### Kubernetes

- Kubernetes Deployments
- Services
- ConfigMaps
- Secrets
- Minikube
- NodePort

### Architecture

- Private cloud networking
- Multi-AZ architecture
- High availability
- Load balancing
- Auto Scaling
- Infrastructure automation

---

# 🚀 Future Improvements

The project can be extended further by implementing:

- Amazon EKS for managed Kubernetes
- Amazon ECR for container images
- Amazon RDS for managed MySQL
- HTTPS using AWS Certificate Manager
- Custom domain using Route 53
- CloudWatch dashboards
- CloudWatch alarms
- Centralized application logging
- Prometheus monitoring
- Grafana dashboards
- Helm charts
- Advanced Auto Scaling policies
- Terraform remote state
- Terraform state locking
- DevSecOps security scanning
- Blue/Green deployments
- Automated deployment to AWS after CI
- AWS Secrets Manager / Parameter Store

---

# 🧹 Destroy AWS Infrastructure

AWS resources should be destroyed after testing when they are no longer required to avoid unnecessary charges.

Navigate to:

```bash
cd terraform
```

Preview destruction:

```bash
terraform plan -destroy
```

Destroy:

```bash
terraform destroy
```

Confirm:

```text
yes
```

Afterward, verify in the AWS Console that billable resources have been removed.

---

# 📸 Project Evidence

The `Screenshots/` directory contains implementation and verification evidence captured throughout the project.

The complete project report documents:

- Local Docker deployment
- Docker containers
- Docker Hub image
- GitHub Actions CI/CD
- AWS VPC
- Public/private subnets
- Private EC2
- User Data
- Systems Manager
- Amazon S3
- S3 versioning
- VPC Endpoints
- Kubernetes
- Application Load Balancer
- Auto Scaling Group
- Healthy Target Group
- Final application verification

---

# 🎥 Project Demo

A complete project demonstration covers:

1. Application functionality
2. Docker and Docker Compose
3. Docker Hub
4. GitHub Actions CI/CD
5. Terraform
6. AWS VPC architecture
7. Private EC2 deployment
8. Systems Manager
9. Amazon S3
10. S3 versioning
11. S3 Gateway Endpoint
12. Kubernetes deployment
13. Application Load Balancer
14. Auto Scaling Group
15. Healthy Target Group
16. Live application verification

### Demo Video

```text
https://drive.google.com/file/d/1ae2s9nPz4r1gUaTBfZZ3Zgsan5DmcDxm/view?usp=drive_link
```

---

# 📚 Documentation

The project includes a detailed **Final Consolidated Project Report** containing the architecture, implementation steps, screenshots, verification evidence, and stretch-goal deployment.

The documentation covers the project from local development through the final ALB + Auto Scaling deployment.

---

# 👨‍💻 Author

**Dilip Kumar**

### GitHub

```text
https://github.com/Dilip714
```

### Project Repository

```text
https://github.com/Dilip714/Personal-Notes-App-V2
```

---

# 📄 License

This project is intended for educational, DevOps learning, internship, and portfolio purposes.

A standard open-source license such as the **MIT License** can be added if the project is intended for public reuse.

---

# ⭐ Personal Notes App V2

### End-to-End DevOps Deployment Pipeline

**Docker • GitHub Actions • Terraform • AWS • Kubernetes**

A complete DevOps project demonstrating:

> **Containerization → CI/CD → Infrastructure as Code → Secure Cloud Networking → Private Compute → Kubernetes → Load Balancing → Auto Scaling → High Availability**

If you found this project useful, consider giving the repository a ⭐.
