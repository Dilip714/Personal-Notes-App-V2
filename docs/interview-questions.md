# Interview Q&A Bank

**Q: Why put the EC2 instance in a private subnet instead of a public one?**
A: Reduces attack surface — no direct internet exposure. Access is managed
via SSM Session Manager, and outbound needs (like reaching S3) are handled
through a VPC Endpoint instead of routing through the public internet.

**Q: What's the difference between a Gateway Endpoint and an Interface Endpoint?**
A: A Gateway Endpoint (used here for S3 and also available for DynamoDB)
adds a route to a route table and has no hourly cost. An Interface Endpoint
creates an ENI with a private IP in your subnet (backed by AWS PrivateLink)
and incurs an hourly + per-GB charge, but supports many more services.

**Q: Why does the private route table only need one extra route for S3 access?**
A: The Gateway Endpoint inserts a route to the S3 prefix list directly into
the private route table — no NAT Gateway or Internet Gateway hop needed,
since traffic to S3 stays within the AWS network.

**Q: Why use gunicorn instead of `flask run` in the Dockerfile?**
A: Flask's built-in server is single-threaded and meant for development only.
Gunicorn is a production WSGI server that can run multiple worker processes,
handling concurrent requests reliably.

**Q: Why install requirements before copying the rest of the app code in the Dockerfile?**
A: Docker layer caching — if only application code changes (not
dependencies), Docker reuses the cached `pip install` layer, making rebuilds
much faster.

**Q: What's the purpose of readiness vs. liveness probes in Kubernetes?**
A: Readiness determines if a pod should receive traffic (e.g., still
starting up); liveness determines if a pod is unhealthy and should be
restarted. They serve different failure scenarios.

**Q: Why version-tag Docker images with the Git SHA instead of only using `latest`?**
A: `latest` is mutable and ambiguous — you can't tell which code is actually
running. A SHA-based tag ties every deployed image back to an exact commit,
which is critical for rollbacks and audits.

**Q: What would you change to make this architecture more production-ready?**
A: Move MySQL to RDS with automated backups and Multi-AZ; add an ALB with
ACM-managed HTTPS; add the Auto Scaling Group (Part 14) for resilience;
centralize logs and metrics; add a proper secrets manager instead of `.env`
files or plain Kubernetes Secrets.

**Q: How does GitHub Actions know which Docker Hub account to push to?**
A: Via repository secrets (`DOCKERHUB_USERNAME`, `DOCKERHUB_TOKEN`) injected
as environment variables into the workflow — never hardcoded in the YAML.

**Q: Why use an Auto Scaling Group instead of a single EC2 instance (stretch goal)?**
A: Self-healing (unhealthy instances are replaced automatically), the app
survives an AZ outage since instances span two AZs, and capacity scales
between a min/max range instead of being fixed.
