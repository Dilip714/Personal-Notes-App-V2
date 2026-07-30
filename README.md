# 📝 Personal Notes App — End-to-End DevOps Deployment Pipeline
## Project V2

A production-style DevOps project demonstrating the complete software delivery lifecycle using **Docker**, **GitHub Actions**, **Terraform**, **AWS**, **Amazon S3**, **AWS Systems Manager**, and **Kubernetes**.

![Docker](https://img.shields.io/badge/Docker-Containerized-2496ED?logo=docker&logoColor=white)
![Terraform](https://img.shields.io/badge/IaC-Terraform-844FBA?logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/Cloud-AWS-FF9900?logo=amazonaws&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Orchestration-Kubernetes-326CE5?logo=kubernetes&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/CI/CD-GitHub%20Actions-2088FF?logo=githubactions&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.12-blue?logo=python)
![Flask](https://img.shields.io/badge/Backend-Flask-black?logo=flask)
![License](https://img.shields.io/badge/License-MIT-green)

---

# 📖 Project Overview

Personal Notes App is a full-stack Notes/Journal web application built using **Flask** and **MySQL**.

This project demonstrates a complete DevOps workflow from local development to cloud deployment using Infrastructure as Code.

The application is deployed in two different environments:

- ☁️ **AWS Private EC2** using Terraform
- ☸️ **Kubernetes (Minikube)**

Unlike a traditional deployment that pulls Docker images directly from Docker Hub, this project packages the Docker image as a TAR archive, uploads it to Amazon S3, and deploys it securely to a private EC2 instance through an Amazon S3 Gateway VPC Endpoint.

This approach eliminates the need for a NAT Gateway while keeping the application completely private.

---

# ✨ Features

- Create Notes
- Edit Notes
- Delete Notes
- View Notes
- Health Check Endpoint
- Responsive UI
- Dockerized Application
- Infrastructure as Code
- Automated Deployment
- Kubernetes Deployment

---

# 🏗️ Architecture

```
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
```

---

# 🛡️ Architecture Highlights

- Private EC2 Instance (No Public IP)
- No SSH Access Required
- AWS Systems Manager Session Manager
- Amazon S3 Versioning
- S3 Gateway VPC Endpoint
- Interface Endpoints
- Infrastructure as Code
- Automated Bootstrap
- Secure IAM Roles
- Dockerized Deployment

---

# 🛠️ Technology Stack

| Layer | Technology |
|--------|------------|
| Frontend | HTML5, CSS3, JavaScript |
| Backend | Python Flask |
| WSGI | Gunicorn |
| Database | MySQL 8 |
| Containerization | Docker |
| Local Orchestration | Docker Compose |
| CI/CD | GitHub Actions |
| IaC | Terraform |
| Cloud | AWS |
| Compute | EC2 |
| Storage | Amazon S3 |
| Networking | Amazon VPC |
| Management | AWS Systems Manager |
| Orchestration | Kubernetes (Minikube) |

---

# 📂 Project Structure

```
Personal-Notes-App-V2/
│
├── app/
│   ├── app.py
│   ├── models.py
│   ├── templates/
│   ├── static/
│   ├── requirements.txt
│   ├── Dockerfile
│   ├── test_app.py
│   └── .env.example
│
├── terraform/
│   ├── providers.tf
│   ├── versions.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── network.tf
│   ├── security.tf
│   ├── iam.tf
│   ├── ec2.tf
│   ├── s3.tf
│   ├── vpc_endpoint.tf
│   ├── user_data.sh.tpl
│   └── terraform.tfvars.example
│
├── docker-compose.yml
├── k8s/
├── docs/
├── .github/
│   └── workflows/
│       └── ci.yml
│
└── README.md
```

---

# 🚀 Local Setup

```bash
git clone https://github.com/Dilip714/Personal-Notes-App-V2.git

cd Personal-Notes-App-V2
```

Create environment file

```bash
cp app/.env.example app/.env
```

Run locally

```bash
docker compose up --build
```

Application

```
http://localhost:15000
```

---

# 🐳 Docker

Build Image

```bash
docker build -t notes-app:v2 ./app
```

Run

```bash
docker run -p 5000:5000 notes-app:v2
```

Push

```bash
docker login

docker tag notes-app:v2 dilipdev714/notes-app:v2

docker push dilipdev714/notes-app:v2
```

---

# ⚙️ CI/CD Pipeline

GitHub Actions automatically performs:

- Checkout Source Code
- Install Python
- Install Dependencies
- Execute Tests
- Build Docker Image
- Login to Docker Hub
- Push Docker Image

Pipeline executes automatically whenever code is pushed to the **main** branch.

---

# ☁️ AWS Infrastructure

Terraform provisions:

- Amazon VPC
- Internet Gateway
- Public Subnets
- Private Subnets
- Route Tables
- Security Groups
- IAM Role
- IAM Instance Profile
- EC2 Instance
- Amazon S3 Bucket
- S3 Versioning
- Gateway Endpoint
- Interface Endpoints
- Systems Manager Access

Deploy

```bash
cd terraform

terraform init

terraform plan

terraform apply
```

Destroy

```bash
terraform destroy
```

---

# 🚀 EC2 Bootstrap Process

During instance launch, EC2 automatically performs:

1. Update packages
2. Install Docker
3. Install AWS CLI
4. Download Docker image archive from Amazon S3
5. Load Docker image
6. Run Notes App container
7. Register with Systems Manager

No manual deployment steps are required.

---

# 🪣 Amazon S3 Deployment Workflow

Instead of pulling the image directly from Docker Hub, the deployment uses:

```
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
```

Benefits:

- No NAT Gateway
- Lower AWS Cost
- Secure Private Deployment
- Faster Artifact Distribution

## Amazon S3 Versioning

Amazon S3 Versioning was enabled on the bucket used for application static assets.

Demonstrated:

- Uploaded multiple versions of `style.css`
- Listed object versions using the AWS CLI
- Restored a previous version using:

```bash
aws s3api copy-object \
--bucket notes-app-v2-static-assets-582500932246 \
--copy-source "notes-app-v2-static-assets-582500932246/css/style.css?versionId=<OLD_VERSION_ID>" \
--key css/style.css
```

This demonstrates object recovery without deleting existing versions.

---

# 🔒 Security

- Private EC2
- No Public IP
- No SSH Port Open
- Session Manager Access
- IAM Roles
- Private Subnets
- Gateway Endpoint
- Interface Endpoints
- Least Privilege Access

---

# ☸️ Kubernetes Deployment

```bash
minikube start

kubectl apply -f k8s/
```

Check

```bash
kubectl get pods

kubectl get svc
```

---

# ✅ Verification

### Docker

- Docker Image Built
- Docker Compose Working

### AWS

- Terraform Apply Successful
- EC2 Running
- Private Subnet
- S3 Bucket Created
- Gateway Endpoint Working
- Session Manager Connected

### Application

```bash
sudo docker ps
```

Health Check

```bash
curl http://localhost:5000/health
```

Output

```json
{
    "status":"ok"
}
```

---

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

---

# 📸 Screenshots

Recommended screenshots:

- Local Application
- Docker Containers
- Docker Hub Repository
- GitHub Actions Success
- Terraform Apply
- AWS VPC
- EC2 Instance
- S3 Bucket
- Session Manager
- Docker Running on EC2
- Health Check
- Kubernetes Pods

---

# 🚀 Future Improvements

- Application Load Balancer
- Auto Scaling Group
- Amazon RDS
- Amazon ECR
- CloudWatch Dashboard
- Helm Charts
- HTTPS using ACM
- Monitoring with Prometheus & Grafana

---

# 🎯 Learning Outcomes

This project demonstrates practical experience with:

- Docker
- Docker Compose
- GitHub Actions
- Terraform
- AWS VPC
- EC2
- IAM
- Amazon S3
- Gateway Endpoints
- Systems Manager
- Kubernetes
- Infrastructure as Code
- DevOps Best Practices

---

# 👨‍💻 Author

**Dilip Kumar**

GitHub:
https://github.com/Dilip714

---

# 📄 License

This project is licensed under the MIT License.