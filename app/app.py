"""
Personal Notes App - Flask Backend
-----------------------------------
Provides a REST-style API + server-rendered UI for CRUD operations on notes,
backed by a MySQL database. Configuration is pulled entirely from environment
variables so the same image can run locally, in Docker, or on EC2 without
code changes (12-factor style).
"""

import os
import time

import pymysql
from flask import Flask, jsonify, render_template, request

app = Flask(__name__)

# ---------------------------------------------------------------------------
# Configuration (all values come from environment variables — never hardcode
# credentials. Defaults below are safe for local dev only.)
# ---------------------------------------------------------------------------
DB_HOST = os.environ.get("DB_HOST", "localhost")
DB_PORT = int(os.environ.get("DB_PORT", 3306))
DB_USER = os.environ.get("DB_USER", "notes_user")
DB_PASSWORD = os.environ.get("DB_PASSWORD", "notes_password")
DB_NAME = os.environ.get("DB_NAME", "notes_db")


def get_connection(retries=5, delay=3):
    """
    Open a MySQL connection, retrying briefly.

    Why retries? In docker-compose / Kubernetes, the Flask container often
    starts before MySQL has finished initializing. Retrying avoids a crash
    loop on first boot.
    """
    last_err = None
    for attempt in range(1, retries + 1):
        try:
            return pymysql.connect(
                host=DB_HOST,
                port=DB_PORT,
                user=DB_USER,
                password=DB_PASSWORD,
                database=DB_NAME,
                cursorclass=pymysql.cursors.DictCursor,
                autocommit=True,
            )
        except pymysql.err.OperationalError as err:
            last_err = err
            time.sleep(delay)
    raise last_err


def init_db():
    """Create the notes table if it doesn't already exist."""
    conn = get_connection()
    try:
        with conn.cursor() as cur:
            cur.execute(
                """
                CREATE TABLE IF NOT EXISTS notes (
                    id INT AUTO_INCREMENT PRIMARY KEY,
                    title VARCHAR(255) NOT NULL,
                    content TEXT NOT NULL,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                                ON UPDATE CURRENT_TIMESTAMP
                )
                """
            )
    finally:
        conn.close()


# ---------------------------------------------------------------------------
# UI route
# ---------------------------------------------------------------------------
@app.route("/")
def index():
    return render_template("index.html")


# ---------------------------------------------------------------------------
# Health check (used by Docker/K8s liveness & readiness probes)
# ---------------------------------------------------------------------------
@app.route("/health")
def health():
    return jsonify({"status": "ok"}), 200


# ---------------------------------------------------------------------------
# CRUD API
# ---------------------------------------------------------------------------
@app.route("/api/notes", methods=["GET"])
def get_notes():
    conn = get_connection()
    try:
        with conn.cursor() as cur:
            cur.execute("SELECT * FROM notes ORDER BY updated_at DESC")
            notes = cur.fetchall()
        return jsonify(notes), 200
    finally:
        conn.close()


@app.route("/api/notes/<int:note_id>", methods=["GET"])
def get_note(note_id):
    conn = get_connection()
    try:
        with conn.cursor() as cur:
            cur.execute("SELECT * FROM notes WHERE id = %s", (note_id,))
            note = cur.fetchone()
        if not note:
            return jsonify({"error": "Note not found"}), 404
        return jsonify(note), 200
    finally:
        conn.close()


@app.route("/api/notes", methods=["POST"])
def create_note():
    data = request.get_json(silent=True) or {}
    title = (data.get("title") or "").strip()
    content = (data.get("content") or "").strip()

    if not title or not content:
        return jsonify({"error": "title and content are required"}), 400

    conn = get_connection()
    try:
        with conn.cursor() as cur:
            cur.execute(
                "INSERT INTO notes (title, content) VALUES (%s, %s)",
                (title, content),
            )
            new_id = cur.lastrowid
        return jsonify({"id": new_id, "title": title, "content": content}), 201
    finally:
        conn.close()


@app.route("/api/notes/<int:note_id>", methods=["PUT"])
def update_note(note_id):
    data = request.get_json(silent=True) or {}
    title = (data.get("title") or "").strip()
    content = (data.get("content") or "").strip()

    if not title or not content:
        return jsonify({"error": "title and content are required"}), 400

    conn = get_connection()
    try:
        with conn.cursor() as cur:
            cur.execute(
                "UPDATE notes SET title = %s, content = %s WHERE id = %s",
                (title, content, note_id),
            )
            if cur.rowcount == 0:
                return jsonify({"error": "Note not found"}), 404
        return jsonify({"id": note_id, "title": title, "content": content}), 200
    finally:
        conn.close()


@app.route("/api/notes/<int:note_id>", methods=["DELETE"])
def delete_note(note_id):
    conn = get_connection()
    try:
        with conn.cursor() as cur:
            cur.execute("DELETE FROM notes WHERE id = %s", (note_id,))
            if cur.rowcount == 0:
                return jsonify({"error": "Note not found"}), 404
        return jsonify({"message": "Note deleted"}), 200
    finally:
        conn.close()


# ---------------------------------------------------------------------------
# Entrypoint
# ---------------------------------------------------------------------------
if __name__ == "__main__":
    init_db()
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
else:
    # When run under gunicorn (production), still make sure the table exists.
    try:
        init_db()
    except Exception as e:  # noqa: BLE001
        print(f"[startup] DB not ready yet, will retry on first request: {e}")
