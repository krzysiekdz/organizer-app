import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:organizer/features/notes_management/domain/entities/note.dart'
    show Note;
import 'package:organizer/features/notes_management/domain/repositories/note_repository.dart'
    show NoteRepository;
import '../../../domain/entities/folder.dart';
import '../../../domain/repositories/folder_repository.dart';

part 'folder_event.dart';
part 'folder_state.dart';

class FolderContentBloc extends Bloc<FolderContentEvent, FolderContentState> {
  final FolderRepository folderRepository;
  final NoteRepository noteRepository;
  final String userId;
  final String? folderId;
  StreamSubscription<List<Folder>>? _foldersSubscription;
  StreamSubscription<List<Note>>? _notesSubscription;

  FolderContentBloc({
    required this.folderRepository,
    required this.noteRepository,
    required this.userId,
    required this.folderId,
  }) : super(FolderContentLoading()) {
    on<RefreshFolderContent>(_onRefreshFoldersRequested);
    on<FolderContentErrorOccured>(_onFoldersStreamErrorOccurred);
    on<FolderContentDelete>(_onDeleteFolder);
    on<FolderContentChanged>(_onFoldersChanged);

    _subscribe();
  }

  void _subscribe() {
    _foldersSubscription?.cancel();
    _notesSubscription?.cancel();
    List<Folder> tempFolders = [];
    List<Note> tempNotes = [];
    _foldersSubscription = folderRepository
        .watchFolders(userId, folderId)
        .listen(
          (folders) {
            tempFolders = folders;
            add(FolderContentChanged(folders: tempFolders, notes: tempNotes));
          },
          onError: (Object error, StackTrace stackTrace) {
            add(FolderContentErrorOccured(message: error.toString()));
          },
        );
    _notesSubscription = noteRepository
        .watchNotes(userId, folderId)
        .listen(
          (notes) {
            tempNotes = notes;
            add(FolderContentChanged(folders: tempFolders, notes: tempNotes));
          },
          onError: (Object error, StackTrace stackTrace) {
            add(FolderContentErrorOccured(message: error.toString()));
          },
        );
  }

  @override
  Future<void> close() {
    _foldersSubscription?.cancel();
    _notesSubscription?.cancel();
    return super.close();
  }

  Future<void> _onRefreshFoldersRequested(
    RefreshFolderContent event,
    Emitter<FolderContentState> emit,
  ) async {
    emit(FolderContentLoading());
    _subscribe();
  }

  void _onFoldersStreamErrorOccurred(
    FolderContentErrorOccured event,
    Emitter<FolderContentState> emit,
  ) {
    emit(FolderContentLoadError(message: event.message));
  }

  void _onFoldersChanged(
    FolderContentChanged event,
    Emitter<FolderContentState> emit,
  ) {
    // Stream already filtered by this bloc's parentId
    emit(
      FolderContentLoaded(
        folders: event.folders,
        notes: event.notes,
        parentId: folderId,
      ),
    );
  }

  Future<void> _onDeleteFolder(
    FolderContentDelete event,
    Emitter<FolderContentState> emit,
  ) async {
    try {
      if (event.type == FolderContentType.folder) {
        await folderRepository.deleteFolder(event.id);
      } else {
        await noteRepository.deleteNote(event.id);
      }
      // final currentState = state;
      // if (currentState is FolderLoaded) {
      //   final updatedFolders = currentState.folders
      //       .where((folder) => folder.id != event.folderId)
      //       .toList();
      //   emit(FolderLoaded(folders: updatedFolders, parentId: parentId));
      // }
    } catch (e) {
      emit(FolderContentDeleteError(message: e.toString()));
    }
  }
}
