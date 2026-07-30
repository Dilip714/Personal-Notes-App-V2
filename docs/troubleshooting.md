# Troubleshooting Guide

## Docker / Compose
| Symptom | Likely Cause | Fix |
|---|---|---|
| `web` container restarts in a loop | MySQL not ready yet | `depends_on` + `healthcheck` in compose already handle this; if it persists, check `docker compose logs mysql` |
| `Connection refused` to MySQL | Wrong `DB_HOST` | Should be the service name `mysql`, not `localhost`, inside Compose/K8s |
| Port 5000 already in use | Another process bound to it | `lsof -i :5000` then kill it, or change the host port mapping |

## Docker Hub
| Symptom | Likely Cause | Fix |
|---|---|---|
| `denied: requested access to the resource is denied` | Not logged in / wrong repo name | Run `docker login`; ensure tag matches `<username>/<repo>:<tag>` exactly |

## Terraform
| Symptom | Likely Cause | Fix |
|---|---|---|
| `Error: no valid credential sources` | AWS CLI not configured | Run `aws configure` with a valid access key/secret |
| `InvalidAMIID.NotFound` | AMI filter matched nothing in your region | Confirm the region has `al2023-ami-*` images, or pin a specific AMI ID |
| Apply hangs on EC2 creation | Subnet/AZ mismatch | Ensure `availability_zones` matches subnets actually available in `aws_region` |

## Private EC2 / S3 Endpoint
| Symptom | Likely Cause | Fix |
|---|---|---|
| EC2 can't reach S3 | Endpoint not associated with the right route table | Check `route_table_ids` on `aws_vpc_endpoint.s3` matches the private RT |
| `docker pull` fails on EC2 boot | No internet path to Docker Hub from a fully private subnet | For a pure "no NAT" design, stage the image in S3/ECR instead, or add a NAT Gateway if Docker Hub access is required |

## GitHub Actions
| Symptom | Likely Cause | Fix |
|---|---|---|
| `Error: Username and password required` | Missing repo secrets | Add `DOCKERHUB_USERNAME` / `DOCKERHUB_TOKEN` under Settings → Secrets |
| Tests fail in CI but pass locally | Missing test dependency in `requirements.txt` | Ensure `pytest` is listed and installed in the workflow |

## Kubernetes
| Symptom | Likely Cause | Fix |
|---|---|---|
| Pod stuck in `ImagePullBackOff` | Image name/tag wrong or private repo without imagePullSecret | Verify the image exists on Docker Hub and is public, or add a pull secret |
| Pod `CrashLoopBackOff` | App can't reach `mysql-service` yet | Check `kubectl logs <pod>`; confirm `mysql` deployment is Running first |
| NodePort not reachable | Using `localhost` instead of Minikube's IP | Use `minikube service notes-app-service --url` |
