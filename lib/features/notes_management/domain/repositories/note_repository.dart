import '../entities/note.dart';

abstract interface class NoteRepository {
  Future<List<Note>> getNotesByFolderId(String userId, String? folderId);
  Future<Note> createNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(String noteId);
  Future<Note?> getNoteById(String noteId);
}
