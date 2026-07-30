# Screenshots Checklist

Capture these for your submission/portfolio:

## Application
- [ ] UI homepage with a few notes displayed
- [ ] Creating a new note (form filled in)
- [ ] Editing an existing note
- [ ] Deleting a note (confirmation + updated list)

## Docker
- [ ] `docker build` output (successful)
- [ ] `docker compose up` output showing both containers healthy
- [ ] `docker ps` showing running containers
- [ ] App running in browser via container (`localhost:5000`)

## Docker Hub
- [ ] `docker push` output
- [ ] Docker Hub repository page showing `v1` and `latest` tags

## Terraform / AWS
- [ ] `terraform plan` output
- [ ] `terraform apply` completing successfully
- [ ] AWS Console: VPC with public + private subnets visible
- [ ] AWS Console: EC2 instance details showing **no public IP**
- [ ] AWS Console: Route table showing the S3 prefix-list route
- [ ] AWS Console: VPC Endpoints page showing the S3 Gateway Endpoint

## S3 Versioning
- [ ] S3 bucket with versioning enabled
- [ ] Object with multiple versions listed
- [ ] Restoring a previous version

## GitHub Actions
- [ ] Green (passing) workflow run
- [ ] Workflow log showing test + build + push steps

## Kubernetes
- [ ] `kubectl get pods` showing Running pods
- [ ] `kubectl get svc` showing the NodePort service
- [ ] App accessible via `minikube service --url`
