import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/note.dart';
import '../models/note_model.dart';

abstract class NoteRemoteDataSource {
  Future<List<Note>> getNotesByFolderId(String userId, String? folderId);
  Future<Note> createNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(String noteId);
  Future<Note?> getNoteById(String noteId);
}

class NoteRemoteDataSourceImpl implements NoteRemoteDataSource {
  final FirebaseFirestore firestore;

  NoteRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<Note>> getNotesByFolderId(String userId, String? folderId) async {
    Query query = firestore
        .collection('notes')
        .where('userId', isEqualTo: userId);

    if (folderId == null) {
      query = query.where('folderId', isNull: true);
    } else {
      query = query.where('folderId', isEqualTo: folderId);
    }

    final querySnapshot = await query
        .orderBy('createdAt', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => NoteModel.fromFirestore(doc))
        .toList();
  }

  @override
  Future<Note> createNote(Note note) async {
    final docRef = firestore.collection('notes').doc();
    final noteData = NoteModel.toFirestore(note);
    noteData['id'] = docRef.id;
    await docRef.set(noteData);

    // Return the note with the new ID
    return NoteModel.fromFirestore(await docRef.get());
  }

  @override
  Future<void> updateNote(Note note) async {
    final noteData = NoteModel.toFirestore(note);
    await firestore.collection('notes').doc(note.id).update(noteData);
  }

  @override
  Future<void> deleteNote(String noteId) async {
    await firestore.collection('notes').doc(noteId).delete();
  }

  @override
  Future<Note?> getNoteById(String noteId) async {
    final doc = await firestore.collection('notes').doc(noteId).get();
    if (!doc.exists) return null;
    return NoteModel.fromFirestore(doc);
  }
}
