part of 'folder_bloc.dart';

sealed class FolderState extends Equatable {
  const FolderState();

  @override
  List<Object?> get props => [];
}

class FolderLoading extends FolderState {}

class FolderLoaded extends FolderState {
  final List<Folder> folders;
  /// Current view filter: null = root folders, non-null = children of that parent.
  final String? parentId;

  const FolderLoaded({required this.folders, this.parentId});

  @override
  List<Object?> get props => [folders, parentId];
}

class FolderError extends FolderState {
  final String message;

  const FolderError({required this.message});

  @override
  List<Object?> get props => [message];
}

