# Project Roadmap — Build Order

Work through these in order; each stage is independently testable before
moving to the next.

1. **App development** — run `app/app.py` locally against a local MySQL
   (or `docker compose up` for the DB only) and verify all four CRUD
   operations through the UI and `/api/notes`.
2. **Dockerize** — `docker build`, run standalone, confirm `/health` and the
   UI work in a container.
3. **Compose** — `docker compose up`, confirm app + MySQL talk to each other
   using the service name `mysql` as `DB_HOST`.
4. **Docker Hub** — create a repo, `docker login`, tag and push `v1`.
5. **Terraform init/plan/apply** — provision VPC → subnets → IGW/route
   tables → security group → IAM role → EC2 → S3 → VPC Endpoint, in that
   dependency order (Terraform handles ordering automatically from the
   resource graph, but understanding it helps when debugging).
6. **Verify EC2 bootstrap** — connect via SSM, confirm the container from
   Docker Hub is running (`docker ps`) and `/health` responds locally on
   the instance.
7. **Verify Gateway Endpoint** — confirm S3 access works and general
   internet access does not, from inside the private instance.
8. **S3 versioning** — upload a static asset twice, list versions, restore
   an older one.
9. **GitHub Actions** — add Docker Hub secrets to the repo, push to `main`,
   confirm the workflow goes green and a new tagged image appears on
   Docker Hub.
10. **Kubernetes** — `minikube start`, apply manifests in order (secret →
    configmap → mysql → deployment → service), verify pods and NodePort
    access.
11. **Architecture diagram** — generate via `docs/generate_diagram.py`
    (uses the Python `diagrams` library) or update manually as the design
    evolves.
12. **README + docs** — keep in sync as you go, rather than writing it all
    at the end.
13. **Demo** — rehearse using `docs/demo-script.md` before presenting.
14. **Stretch goal (optional)** — swap the single EC2 for the ALB + ASG
    setup in `terraform-stretch-asg/` once the base project is solid.
