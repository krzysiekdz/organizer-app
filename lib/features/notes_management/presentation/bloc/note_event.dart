part of 'note_bloc.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotes extends NoteEvent {
  const LoadNotes();
}

class LoadNotesByFolderId extends NoteEvent {
  final String? folderId;

  const LoadNotesByFolderId({required this.folderId});

  @override
  List<Object?> get props => [folderId];
}

class CreateNote extends NoteEvent {
  final Note note;

  const CreateNote({required this.note});

  @override
  List<Object?> get props => [note];
}

class UpdateNote extends NoteEvent {
  final Note note;

  const UpdateNote({required this.note});

  @override
  List<Object?> get props => [note];
}

class DeleteNote extends NoteEvent {
  final String noteId;

  const DeleteNote({required this.noteId});

  @override
  List<Object?> get props => [noteId];
}

