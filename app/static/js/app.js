// Personal Notes App - Frontend logic
// Talks to the Flask REST API at /api/notes for all CRUD operations.

const API_URL = "/api/notes";

const notesList = document.getElementById("notes-list");
const emptyState = document.getElementById("empty-state");
const noteIdField = document.getElementById("note-id");
const titleField = document.getElementById("note-title");
const contentField = document.getElementById("note-content");
const saveBtn = document.getElementById("save-btn");
const cancelBtn = document.getElementById("cancel-btn");

async function fetchNotes() {
  const res = await fetch(API_URL);
  const notes = await res.json();
  renderNotes(notes);
}

function renderNotes(notes) {
  notesList.innerHTML = "";
  if (!notes.length) {
    notesList.appendChild(emptyState);
    return;
  }
  notes.forEach((note) => {
    const card = document.createElement("div");
    card.className = "note-card";
    card.innerHTML = `
      <h3>${escapeHtml(note.title)}</h3>
      <p>${escapeHtml(note.content)}</p>
      <div class="note-actions">
        <button class="edit">Edit</button>
        <button class="delete">Delete</button>
      </div>
    `;
    card.querySelector(".edit").addEventListener("click", () => startEdit(note));
    card.querySelector(".delete").addEventListener("click", () => deleteNote(note.id));
    notesList.appendChild(card);
  });
}

function escapeHtml(str) {
  const div = document.createElement("div");
  div.textContent = str;
  return div.innerHTML;
}

function startEdit(note) {
  noteIdField.value = note.id;
  titleField.value = note.title;
  contentField.value = note.content;
  cancelBtn.style.display = "inline-block";
  saveBtn.textContent = "Update Note";
  window.scrollTo({ top: 0, behavior: "smooth" });
}

function resetForm() {
  noteIdField.value = "";
  titleField.value = "";
  contentField.value = "";
  cancelBtn.style.display = "none";
  saveBtn.textContent = "Save Note";
}

async function saveNote() {
  const id = noteIdField.value;
  const title = titleField.value.trim();
  const content = contentField.value.trim();

  if (!title || !content) {
    alert("Please fill in both title and content.");
    return;
  }

  const payload = { title, content };
  const isEdit = Boolean(id);
  const url = isEdit ? `${API_URL}/${id}` : API_URL;
  const method = isEdit ? "PUT" : "POST";

  const res = await fetch(url, {
    method,
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify(payload),
  });

  if (!res.ok) {
    const err = await res.json();
    alert(err.error || "Something went wrong.");
    return;
  }

  resetForm();
  fetchNotes();
}

async function deleteNote(id) {
  if (!confirm("Delete this note?")) return;
  const res = await fetch(`${API_URL}/${id}`, { method: "DELETE" });
  if (res.ok) fetchNotes();
}

saveBtn.addEventListener("click", saveNote);
cancelBtn.addEventListener("click", resetForm);

fetchNotes();
