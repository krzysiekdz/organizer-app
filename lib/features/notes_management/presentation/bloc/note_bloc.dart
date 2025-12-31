import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/note.dart';
import '../../domain/entities/text_note.dart';
import '../../domain/entities/todo_note.dart';
import '../../domain/entities/list_note.dart';
import '../../domain/repositories/note_repository.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteRepository noteRepository;
  final String userId;

  NoteBloc({
    required this.noteRepository,
    required this.userId,
  }) : super(NoteInitial()) {
    on<LoadNotes>(_onLoadNotes);
    on<LoadNotesByFolderId>(_onLoadNotesByFolderId);
    on<CreateNote>(_onCreateNote);
    on<UpdateNote>(_onUpdateNote);
    on<DeleteNote>(_onDeleteNote);
  }

  Future<void> _onLoadNotes(
      LoadNotes event, Emitter<NoteState> emit) async {
    emit(NoteLoading());
    try {
      final notes = await noteRepository.getNotes(userId);
      emit(NoteLoaded(notes: notes));
    } catch (e) {
      emit(NoteError(message: e.toString()));
    }
  }

  Future<void> _onLoadNotesByFolderId(
      LoadNotesByFolderId event, Emitter<NoteState> emit) async {
    emit(NoteLoading());
    try {
      final notes = await noteRepository.getNotesByFolderId(
        userId,
        event.folderId,
      );
      emit(NoteLoaded(notes: notes));
    } catch (e) {
      emit(NoteError(message: e.toString()));
    }
  }

  Future<void> _onCreateNote(
      CreateNote event, Emitter<NoteState> emit) async {
    try {
      final note = event.note;
      // Ensure userId is set
      Note noteWithUserId;
      if (note is TextNote) {
        noteWithUserId = TextNote(
          id: '',
          name: note.name,
          folderId: note.folderId,
          userId: userId,
          createdAt: note.createdAt,
          content: note.content,
        );
      } else if (note is TodoNote) {
        noteWithUserId = TodoNote(
          id: '',
          name: note.name,
          folderId: note.folderId,
          userId: userId,
          createdAt: note.createdAt,
          tasks: note.tasks,
        );
      } else if (note is ListNote) {
        noteWithUserId = ListNote(
          id: '',
          name: note.name,
          folderId: note.folderId,
          userId: userId,
          createdAt: note.createdAt,
          items: note.items,
        );
      } else {
        noteWithUserId = note;
      }
      
      await noteRepository.createNote(noteWithUserId);
      add(LoadNotesByFolderId(folderId: note.folderId));
    } catch (e) {
      emit(NoteError(message: e.toString()));
    }
  }

  Future<void> _onUpdateNote(
      UpdateNote event, Emitter<NoteState> emit) async {
    try {
      await noteRepository.updateNote(event.note);
      final currentState = state;
      if (currentState is NoteLoaded) {
        final updatedNotes = currentState.notes.map((note) {
          return note.id == event.note.id ? event.note : note;
        }).toList();
        emit(NoteLoaded(notes: updatedNotes));
      }
    } catch (e) {
      emit(NoteError(message: e.toString()));
    }
  }

  Future<void> _onDeleteNote(
      DeleteNote event, Emitter<NoteState> emit) async {
    try {
      await noteRepository.deleteNote(event.noteId);
      final currentState = state;
      if (currentState is NoteLoaded) {
        final updatedNotes = currentState.notes
            .where((note) => note.id != event.noteId)
            .toList();
        emit(NoteLoaded(notes: updatedNotes));
      }
    } catch (e) {
      emit(NoteError(message: e.toString()));
    }
  }
}

