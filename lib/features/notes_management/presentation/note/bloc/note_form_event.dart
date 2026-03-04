part of 'note_form_bloc.dart';

abstract class NoteFormEvent extends Equatable {
  const NoteFormEvent();

  @override
  List<Object?> get props => [];
}

class CreateNoteSubmitted extends NoteFormEvent {
  final Note note;

  const CreateNoteSubmitted({required this.note});

  @override
  List<Object?> get props => [note];
}

class UpdateNoteSubmitted extends NoteFormEvent {
  final Note note;

  const UpdateNoteSubmitted({required this.note});

  @override
  List<Object?> get props => [note];
}
