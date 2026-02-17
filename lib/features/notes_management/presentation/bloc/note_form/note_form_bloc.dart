import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/note.dart';
import '../../../domain/repositories/note_repository.dart';

part 'note_form_event.dart';
part 'note_form_state.dart';

class NoteFormBloc extends Bloc<NoteFormEvent, NoteFormState> {
  final NoteRepository noteRepository;
  final String userId;

  NoteFormBloc({required this.noteRepository, required this.userId})
    : super(NoteFormInitial()) {
    on<CreateNoteSubmitted>(_onCreateNoteSubmitted);
    on<UpdateNoteSubmitted>(_onUpdateNoteSubmitted);
  }

  Future<void> _onCreateNoteSubmitted(
    CreateNoteSubmitted event,
    Emitter<NoteFormState> emit,
  ) async {
    emit(NoteFormLoading());
    try {
      await noteRepository.createNote(event.note.copyWith(userId: userId));
      emit(NoteFormSuccess());
    } catch (e) {
      emit(NoteFormError(message: e.toString()));
    }
  }

  Future<void> _onUpdateNoteSubmitted(
    UpdateNoteSubmitted event,
    Emitter<NoteFormState> emit,
  ) async {
    emit(NoteFormLoading());
    try {
      await noteRepository.updateNote(event.note);
      emit(NoteFormSuccess());
    } catch (e) {
      emit(NoteFormError(message: e.toString()));
    }
  }
}
