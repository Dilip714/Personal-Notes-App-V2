"""
Minimal test suite for CI. Exercises the health check and validates that
malformed CRUD requests are rejected, without requiring a live MySQL
connection (import-safe for GitHub Actions runners).
"""

import pytest

import app as app_module


@pytest.fixture
def client():
    app_module.app.config["TESTING"] = True
    with app_module.app.test_client() as client:
        yield client


def test_health_check(client):
    response = client.get("/health")
    assert response.status_code == 200
    assert response.get_json()["status"] == "ok"


def test_create_note_requires_title_and_content(client):
    response = client.post("/api/notes", json={"title": "", "content": ""})
    assert response.status_code == 400
