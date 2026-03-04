part of 'folder_bloc.dart';

sealed class FolderContentState extends Equatable {
  const FolderContentState();

  @override
  List<Object?> get props => [];
}

class FolderContentLoading extends FolderContentState {}

class FolderContentLoaded extends FolderContentState {
  final List<Folder> folders;
  final List<Note> notes;

  /// Current view filter: null = root folders, non-null = children of that parent.
  final String? parentId;

  const FolderContentLoaded({
    required this.folders,
    required this.notes,
    this.parentId,
  });

  List<dynamic> get content => [...folders, ...notes];

  @override
  List<Object?> get props => [folders, notes, parentId];
}

class FolderContentLoadError extends FolderContentState {
  final String message;

  const FolderContentLoadError({required this.message});

  @override
  List<Object?> get props => [message];
}

class FolderContentDeleteError extends FolderContentState {
  final String message;

  const FolderContentDeleteError({required this.message});

  @override
  List<Object?> get props => [message];
}
