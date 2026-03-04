import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/folder.dart';
import '../../../domain/repositories/folder_repository.dart';

part 'folder_form_event.dart';
part 'folder_form_state.dart';

class FolderFormBloc extends Bloc<FolderFormEvent, FolderFormState> {
  final FolderRepository folderRepository;
  final String userId;

  FolderFormBloc({required this.folderRepository, required this.userId})
    : super(FolderFormInitial()) {
    on<CreateFolderSubmitted>(_onCreateFolderSubmitted);
    on<UpdateFolderSubmitted>(_onUpdateFolderSubmitted);
  }

  Future<void> _onCreateFolderSubmitted(
    CreateFolderSubmitted event,
    Emitter<FolderFormState> emit,
  ) async {
    emit(FolderFormLoading());
    try {
      final folder = Folder(
        id: '',
        name: event.name,
        parentId: event.parentId,
        userId: userId,
        createdAt: DateTime.now(),
      );
      await folderRepository.createFolder(folder);
      emit(FolderFormSuccess());
    } catch (e) {
      emit(FolderFormError(message: e.toString()));
    }
  }

  Future<void> _onUpdateFolderSubmitted(
    UpdateFolderSubmitted event,
    Emitter<FolderFormState> emit,
  ) async {
    emit(FolderFormLoading());
    try {
      await folderRepository.updateFolder(event.folder);
      emit(FolderFormSuccess());
    } catch (e) {
      emit(FolderFormError(message: e.toString()));
    }
  }
}
