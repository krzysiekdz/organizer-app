part of 'note_form_bloc.dart';

abstract class NoteFormState extends Equatable {
  const NoteFormState();

  @override
  List<Object?> get props => [];
}

class NoteFormInitial extends NoteFormState {}

class NoteFormLoading extends NoteFormState {}

class NoteFormSuccess extends NoteFormState {}

class NoteFormError extends NoteFormState {
  final String message;

  const NoteFormError({required this.message});

  @override
  List<Object?> get props => [message];
}
