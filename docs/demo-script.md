# Demo Script (5–7 minutes)

**0:00–0:30 — Introduction**
"This is a Personal Notes App deployed with a full production-style DevOps
pipeline — Docker, Terraform on AWS, GitHub Actions CI/CD, and Kubernetes."

**0:30–1:30 — Application Demo**
- Show the UI: create a note, edit it, delete it.
- Point out it's a Flask + MySQL app behind a simple HTML/CSS/JS frontend.

**1:30–2:15 — Docker Demo**
- `docker compose up` locally, show both containers running.
- Highlight the Dockerfile's layer-caching and non-root user choices.

**2:15–2:45 — Docker Hub**
- Show the pushed image with `v1` and `latest` tags on Docker Hub.

**2:45–3:45 — Terraform / AWS Console**
- `terraform apply` output (or a pre-run summary).
- AWS Console: VPC with public/private subnets, EC2 instance showing
  **no public IP**.

**3:45–4:30 — Gateway Endpoint Verification**
- From the private EC2 (via SSM): `aws s3 ls` succeeds, `curl google.com`
  times out — proving S3 access without internet access.

**4:30–5:00 — S3 Versioning**
- Show the bucket with multiple object versions and a restore.

**5:00–5:30 — GitHub Actions**
- Show a green workflow run: test → build → push.

**5:30–6:30 — Kubernetes Deployment**
- `kubectl get pods`, `kubectl get svc`, then open the app via
  `minikube service --url`.

**6:30–7:00 — Conclusion**
"This pipeline shows the same Docker image moving through local dev, CI/CD,
private cloud infrastructure, and container orchestration — with security
and cost-conscious choices like private subnets and Gateway Endpoints
throughout."
