import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/folder.dart';
import '../../../domain/repositories/folder_repository.dart';

part 'folder_event.dart';
part 'folder_state.dart';

class FolderBloc extends Bloc<FolderEvent, FoldersState> {
  final FolderRepository folderRepository;
  final String userId;
  final String? parentId;
  StreamSubscription<List<Folder>>? _foldersSubscription;

  FolderBloc({
    required this.folderRepository,
    required this.userId,
    required this.parentId,
  }) : super(FoldersLoading()) {
    on<LoadFoldersByParentId>(_onLoadFoldersByParentId);
    on<DeleteFolder>(_onDeleteFolder);
    on<FoldersChanged>(_onFoldersChanged);

    // Listen to folder collection changes for this view (e.g. edits from another device)
    _foldersSubscription = folderRepository
        .watchFolders(userId, parentId)
        .listen((folders) => add(FoldersChanged(folders: folders)));
  }

  @override
  Future<void> close() {
    _foldersSubscription?.cancel();
    return super.close();
  }

  Future<void> _onLoadFoldersByParentId(
    LoadFoldersByParentId event,
    Emitter<FoldersState> emit,
  ) async {
    emit(FoldersLoading());
    try {
      final folders = await folderRepository.getFoldersByParentId(
        userId,
        parentId,
      );
      emit(FoldersLoaded(folders: folders, parentId: parentId));
    } catch (e) {
      emit(FoldersError(message: e.toString()));
    }
  }

  void _onFoldersChanged(FoldersChanged event, Emitter<FoldersState> emit) {
    // Stream already filtered by this bloc's parentId
    emit(FoldersLoaded(folders: event.folders, parentId: parentId));
  }

  Future<void> _onDeleteFolder(
    DeleteFolder event,
    Emitter<FoldersState> emit,
  ) async {
    try {
      await folderRepository.deleteFolder(event.folderId);
      // final currentState = state;
      // if (currentState is FolderLoaded) {
      //   final updatedFolders = currentState.folders
      //       .where((folder) => folder.id != event.folderId)
      //       .toList();
      //   emit(FolderLoaded(folders: updatedFolders, parentId: parentId));
      // }
    } catch (e) {
      emit(FoldersError(message: e.toString()));
    }
  }
}
