# ---------------------------------------------------------------------------
# Personal Notes App - Dockerfile
# ---------------------------------------------------------------------------
# Small base image: python:3.12-slim instead of the full python image saves
# ~800MB and reduces attack surface.
FROM python:3.12-slim

# Prevents Python from writing .pyc files and buffering stdout — makes
# container logs show up immediately (important for `docker logs`).
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Dedicated working directory instead of dumping files into /.
WORKDIR /app

# Install dependencies BEFORE copying the rest of the source code.
# Docker caches each layer — this means `docker build` only re-installs
# packages when requirements.txt actually changes, not on every code edit.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Now copy the application code.
COPY . .

# Run as a non-root user for security best practice.
RUN useradd --create-home appuser
USER appuser

# Document the port the app listens on (informational; still needs -p on run).
EXPOSE 5000

# Use gunicorn (production WSGI server) instead of Flask's dev server.
# 3 workers is a reasonable default for a small app; tune with CPU cores.
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "--workers", "3", "app:app"]
