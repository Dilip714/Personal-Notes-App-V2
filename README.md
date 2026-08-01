# 📝 Personal Notes App --- End-to-End DevOps Deployment Pipeline

## Project V2

A production-style DevOps project demonstrating the complete software
delivery lifecycle using **Docker**, **GitHub Actions**, **Terraform**,
**AWS**, **Amazon S3**, **AWS Systems Manager**, and **Kubernetes**.

[![Demo
Video](https://img.shields.io/badge/Demo-Video-red?logo=youtube&logoColor=white)](https://drive.google.com/file/d/1ae2s9nPz4r1gUaTBfZZ3Zgsan5DmcDxm/view?usp=sharing)
![Docker](https://img.shields.io/badge/Docker-Containerized-2496ED?logo=docker&logoColor=white)
![Terraform](https://img.shields.io/badge/IaC-Terraform-844FBA?logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/Cloud-AWS-FF9900?logo=amazonaws&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Orchestration-Kubernetes-326CE5?logo=kubernetes&logoColor=white)
![GitHub
Actions](https://img.shields.io/badge/CI/CD-GitHub%20Actions-2088FF?logo=githubactions&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.12-blue?logo=python)
![Flask](https://img.shields.io/badge/Backend-Flask-black?logo=flask)
![License](https://img.shields.io/badge/License-MIT-green)

------------------------------------------------------------------------

# 📖 Project Overview

Personal Notes App is a full-stack Notes/Journal web application built
using **Flask** and **MySQL**.

This project demonstrates a complete DevOps workflow from local
development to cloud deployment using Infrastructure as Code.

The application was validated across multiple deployment scenarios:

-   🐳 **Local Docker Compose** --- Flask + MySQL with full CRUD
-   ☁️ **AWS Base Deployment** --- private EC2 provisioned with
    Terraform
-   ☸️ **Kubernetes (Minikube)** --- Deployment exposed through NodePort
-   ⭐ **AWS Stretch Deployment** --- Application Load Balancer + Auto
    Scaling Group across two Availability Zones

The project demonstrates two deployment strategies.

The application image is automatically built and pushed to Docker Hub
using GitHub Actions.

For AWS deployment, the Docker image is packaged as a TAR archive,
uploaded to Amazon S3, and securely deployed to a private EC2 instance
through an Amazon S3 Gateway VPC Endpoint without requiring a NAT
Gateway.

This design avoids a NAT Gateway for the private EC2-to-S3 path while
keeping the application instances in private subnets.

------------------------------------------------------------------------

# ✨ Features

-   Create Notes
-   Edit Notes
-   Delete Notes
-   View Notes
-   Health Check Endpoint
-   Responsive UI
-   Dockerized Application
-   Infrastructure as Code
-   Automated Deployment
-   Kubernetes Deployment

------------------------------------------------------------------------

# 🏗️ Architecture

                        Developer
                            │
                            ▼
                       GitHub Repository
                            │
                            ▼
                     GitHub Actions CI
                            │
                            ▼
                     Docker Image Build
                            │
                            ▼
                       Docker Hub
                            │
                     docker save
                            │
                            ▼
                 Docker Image Archive (.tar)
                            │
                            ▼
                     Amazon S3 Bucket
                    (Versioning Enabled)
                            │
                S3 Gateway VPC Endpoint
                            │
                            ▼
                  Private EC2 Instance
                  (Amazon Linux 2023)
                            │
                 EC2 User Data Script
                            │
             aws s3 cp → docker load
                            │
                     docker run
                            │
                            ▼
                Personal Notes App
                            │
                            ▼
             AWS Systems Manager
              (Session Manager)

------------------------------------------------------------------------

# 🛡️ Architecture Highlights

-   Private EC2 Instance (No Public IP)
-   No SSH Access Required
-   AWS Systems Manager Session Manager
-   Amazon S3 Versioning
-   S3 Gateway VPC Endpoint
-   Interface Endpoints
-   Infrastructure as Code
-   Automated Bootstrap
-   Secure IAM Roles
-   Dockerized Deployment

------------------------------------------------------------------------

# 🛠️ Technology Stack

  Layer                 Technology
  --------------------- -------------------------
  Frontend              HTML5, CSS3, JavaScript
  Backend               Python Flask
  WSGI                  Gunicorn
  Database              MySQL 8
  Containerization      Docker
  Local Orchestration   Docker Compose
  CI/CD                 GitHub Actions
  IaC                   Terraform
  Cloud                 AWS
  Compute               EC2
  Storage               Amazon S3
  Networking            Amazon VPC
  Management            AWS Systems Manager
  Orchestration         Kubernetes (Minikube)

------------------------------------------------------------------------

# 📂 Project Structure

``` text
Personal-Notes-App-V2/
│
├── .github/
│   └── workflows/
│       └── ci.yml
├── app/
│   ├── static/
│   │   ├── css/style.css
│   │   └── js/app.js
│   ├── templates/index.html
│   ├── .dockerignore
│   ├── .env.example
│   ├── app.py
│   ├── Dockerfile
│   ├── requirements.txt
│   └── test_app.py
├── docs/
│   ├── architecture.png
│   ├── demo-script.md
│   ├── interview-questions.md
│   ├── roadmap.md
│   ├── screenshots-checklist.md
│   └── troubleshooting.md
├── k8s/
│   ├── configmap.yaml
│   ├── deployment.yaml
│   ├── mysql.yaml
│   ├── secret.yaml
│   └── service.yaml
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
├── Screenshots/
├── .gitignore
├── docker-compose.yml
├── README.md
└── versions.json
```

> Terraform state, `.terraform/`, `terraform.tfvars`, `.env`,
> credentials, and other local secrets must not be committed to Git.

------------------------------------------------------------------------

# 🚀 Local Setup

``` bash
git clone https://github.com/Dilip714/Personal-Notes-App-V2.git

cd Personal-Notes-App-V2
```

Create environment file

``` bash
cp app/.env.example app/.env
```

Run locally

``` bash
docker compose up --build
```

Application

    http://localhost:15000

------------------------------------------------------------------------

# 🐳 Docker

Build Image

``` bash
docker build -t notes-app:v2 ./app
```

Run

``` bash
docker run -p 5000:5000 notes-app:v2
```

Push

``` bash
docker login

docker tag notes-app:v2 dilipdev714/notes-app:v2

docker push dilipdev714/notes-app:v2
```

------------------------------------------------------------------------

# ⚙️ CI/CD Pipeline

GitHub Actions automatically performs:

-   Checkout Source Code
-   Install Python
-   Install Dependencies
-   Execute Tests
-   Build Docker Image
-   Login to Docker Hub
-   Push Docker Image

Pipeline executes automatically whenever code is pushed to the **main**
branch.

------------------------------------------------------------------------

# ☁️ AWS Infrastructure

Terraform provisions:

-   Amazon VPC
-   Internet Gateway
-   2 Public Subnets across 2 Availability Zones
-   2 Private Subnets across 2 Availability Zones
-   Route Tables and Associations
-   Security Groups
-   IAM Role and Instance Profile
-   Private EC2 base deployment
-   Amazon S3 Bucket
-   S3 Versioning
-   S3 Gateway VPC Endpoint
-   SSM, SSMMessages, and EC2Messages Interface Endpoints
-   AWS Systems Manager access
-   Application Load Balancer (stretch mode)
-   Target Group and HTTP Listener (stretch mode)
-   Launch Template (stretch mode)
-   Auto Scaling Group (stretch mode)

The base and stretch deployments are managed from the same `terraform/`
configuration. `enable_asg = false` selects the single private EC2 base
deployment, while `enable_asg = true` selects the ALB + Auto Scaling
Group stretch deployment.

Deploy

``` bash
cd terraform

terraform init

terraform plan

terraform apply
```

Destroy

``` bash
terraform destroy
```

------------------------------------------------------------------------

# 🚀 EC2 Bootstrap Process

During instance launch, EC2 automatically performs:

1.  Update packages
2.  Install Docker
3.  Install AWS CLI
4.  Download Docker image archive from Amazon S3
5.  Load Docker image
6.  Run Notes App container
7.  Register with Systems Manager

No manual deployment steps are required.

------------------------------------------------------------------------

# 🪣 Amazon S3 Deployment Workflow

Instead of pulling the image directly from Docker Hub, the deployment
uses:

    Docker Image

    ↓

    docker save

    ↓

    notes-app-v2.tar

    ↓

    Amazon S3

    ↓

    Gateway Endpoint

    ↓

    Private EC2

    ↓

    docker load

    ↓

    docker run

Benefits:

-   No NAT Gateway
-   Lower AWS Cost
-   Secure Private Deployment
-   Faster Artifact Distribution

## Amazon S3 Versioning

Amazon S3 Versioning was enabled on the bucket used for application
static assets.

Demonstrated:

-   Uploaded multiple versions of `style.css`
-   Listed object versions using the AWS CLI
-   Restored a previous version using:

``` bash
aws s3api copy-object \
--bucket notes-app-v2-static-assets-582500932246 \
--copy-source "notes-app-v2-static-assets-582500932246/css/style.css?versionId=<OLD_VERSION_ID>" \
--key css/style.css
```

This demonstrates object recovery without deleting existing versions.

------------------------------------------------------------------------

# 🔒 Security

-   Private EC2
-   No Public IP
-   No SSH Port Open
-   Session Manager Access
-   IAM Roles
-   Private Subnets
-   Gateway Endpoint
-   Interface Endpoints
-   Least Privilege Access

------------------------------------------------------------------------

# ☸️ Kubernetes Deployment

``` bash
minikube start

kubectl apply -f k8s/
```

Check

``` bash
kubectl get pods

kubectl get svc
```

------------------------------------------------------------------------

# ✅ Verification

### Docker

-   Docker Image Built
-   Docker Compose Working

### AWS

-   Terraform Apply Successful
-   EC2 Running
-   Private Subnet
-   S3 Bucket Created
-   Gateway Endpoint Working
-   Session Manager Connected

### Application

``` bash
sudo docker ps
```

Health Check

``` bash
curl http://localhost:5000/health
```

Output

``` json
{
    "status":"ok"
}
```

------------------------------------------------------------------------

# 🔎 Final Verification

  Area                                    Result
  --------------------------------------- ----------------------
  Local Flask + MySQL CRUD                ✅ Verified
  Docker Compose                          ✅ Verified
  Docker image build                      ✅ Verified
  Docker Hub `dilipdev714/notes-app:v2`   ✅ Verified
  GitHub Actions CI/CD                    ✅ Verified
  Terraform validation/apply              ✅ Verified
  VPC + 2 public + 2 private subnets      ✅ Verified
  Private EC2 base deployment             ✅ Verified
  S3 Versioning                           ✅ Verified
  Multiple `style.css` versions           ✅ Verified
  Restore older S3 object version         ✅ Verified
  S3 Gateway VPC Endpoint                 ✅ Verified
  Systems Manager connectivity            ✅ Verified
  Kubernetes Deployment                   ✅ Verified
  Kubernetes NodePort                     ✅ Verified
  ASG 2/2 healthy instances               ✅ Verified
  ALB target group 2/2 healthy            ✅ Verified
  ALB `/health`                           ✅ `{"status":"ok"}`
  Application UI through ALB              ✅ Verified
  Architecture diagram                    ✅ Completed
  Demo video                              ✅ Completed

------------------------------------------------------------------------

# 🏆 Project Achievements

✔ Dockerized Flask Application

✔ GitHub Actions CI/CD

✔ Infrastructure as Code using Terraform

✔ AWS Private Networking

✔ Amazon S3 Versioning

✔ Gateway VPC Endpoint

✔ Session Manager

✔ Kubernetes Deployment

✔ Automated EC2 Bootstrap

✔ Production-style Architecture

✔ Application Load Balancer

✔ Auto Scaling Group

✔ Multi-AZ Stretch Deployment

✔ ALB Health Checks

------------------------------------------------------------------------

# 📸 Screenshots

Recommended screenshots:

-   Local Application
-   Docker Containers
-   Docker Hub Repository
-   GitHub Actions Success
-   Terraform Apply
-   AWS VPC
-   EC2 Instance
-   S3 Bucket
-   Session Manager
-   Docker Running on EC2
-   Health Check
-   Kubernetes Pods

------------------------------------------------------------------------

# 🚀 Future Improvements

-   Deploy the application on Amazon EKS
-   Store container images in Amazon ECR
-   Use Amazon RDS MySQL as the shared database for persistent CRUD
    behind the ALB/ASG
-   Configure HTTPS using AWS Certificate Manager (ACM)
-   Add a custom domain using Route 53
-   Monitor the application with Prometheus & Grafana
-   Configure CloudWatch dashboards and alarms
-   Package Kubernetes resources using Helm

# ⭐ Stretch Goal --- ALB + Auto Scaling Group

The optional stretch goal was successfully implemented and verified.

Implemented:

-   Internet-facing Application Load Balancer
-   ALB Security Group
-   Target Group
-   HTTP Listener
-   Launch Template
-   Auto Scaling Group
-   Multi-AZ private application instances
-   `/health` target health checks
-   Public application endpoint through the ALB

Verified configuration:

``` text
Minimum Capacity : 2
Desired Capacity : 2
Maximum Capacity : 4

ASG Instance #1 : InService / Healthy
ASG Instance #2 : InService / Healthy

Target #1 : healthy
Target #2 : healthy
```

ALB verification:

``` bash
curl http://<ALB-DNS>/health
```

Expected/verified response:

``` json
{"status":"ok"}
```

The application UI was successfully served through the ALB DNS endpoint.

> **Persistence note:** The stretch environment validates ALB routing,
> Auto Scaling, multi-instance availability, target health, and
> application delivery. Persistent CRUD across multiple ASG instances
> would require a shared database such as Amazon RDS MySQL. Full
> MySQL-backed CRUD was validated in the local Docker Compose and
> Kubernetes environments, while RDS is retained as a future
> improvement.

------------------------------------------------------------------------

# 🎯 Learning Outcomes

This project demonstrates practical experience with:

-   Docker
-   Docker Compose
-   GitHub Actions
-   Terraform
-   AWS VPC
-   EC2
-   IAM
-   Amazon S3
-   Gateway Endpoints
-   Systems Manager
-   Kubernetes
-   Infrastructure as Code
-   DevOps Best Practices

# 🎥 Project Demo

A short demonstration of the Personal Notes App covering:

-   Dockerized Flask application
-   GitHub Actions CI/CD pipeline
-   Terraform-based AWS infrastructure
-   Private EC2 deployment
-   Amazon S3 Versioning
-   Gateway VPC Endpoint
-   Kubernetes deployment using Minikube
-   Stretch Goal: Application Load Balancer & Auto Scaling Group

📺 **Watch the complete project demonstration here:**

[▶ Watch Demo
Video](https://drive.google.com/file/d/1ae2s9nPz4r1gUaTBfZZ3Zgsan5DmcDxm/view?usp=sharing)

# ✅ Assignment Completion

  Requirement                Status
  -------------------------- --------
  Notes App                  ✅
  Docker                     ✅
  Docker Hub                 ✅
  Terraform                  ✅
  Public & Private Subnets   ✅
  EC2 in Private Subnet      ✅
  User Data                  ✅
  S3 Versioning              ✅
  Restore Previous Version   ✅
  Gateway VPC Endpoint       ✅
  GitHub Actions             ✅
  Kubernetes Deployment      ✅
  NodePort                   ✅
  Architecture Diagram       ✅
  README                     ✅
  Stretch Goal (ALB + ASG)   ✅

------------------------------------------------------------------------

# 👨‍💻 Author

**Dilip Kumar**

GitHub: https://github.com/Dilip714

------------------------------------------------------------------------

# 📄 License

This project is licensed under the MIT License.
