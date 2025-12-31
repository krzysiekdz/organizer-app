import '../../domain/entities/note.dart';
import '../../domain/repositories/note_repository.dart';
import '../datasources/note_remote_datasource.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteRemoteDataSource remoteDataSource;

  NoteRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Note>> getNotes(String userId) async {
    return await remoteDataSource.getNotes(userId);
  }

  @override
  Future<List<Note>> getNotesByFolderId(String userId, String? folderId) async {
    return await remoteDataSource.getNotesByFolderId(userId, folderId);
  }

  @override
  Future<Note> createNote(Note note) async {
    return await remoteDataSource.createNote(note);
  }

  @override
  Future<void> updateNote(Note note) async {
    await remoteDataSource.updateNote(note);
  }

  @override
  Future<void> deleteNote(String noteId) async {
    await remoteDataSource.deleteNote(noteId);
  }

  @override
  Future<Note?> getNoteById(String noteId) async {
    return await remoteDataSource.getNoteById(noteId);
  }
}

