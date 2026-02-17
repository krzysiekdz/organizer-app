part of 'folder_bloc.dart';

sealed class FoldersState extends Equatable {
  const FoldersState();

  @override
  List<Object?> get props => [];
}

class FoldersLoading extends FoldersState {}

class FoldersLoaded extends FoldersState {
  final List<Folder> folders;

  /// Current view filter: null = root folders, non-null = children of that parent.
  final String? parentId;

  const FoldersLoaded({required this.folders, this.parentId});

  @override
  List<Object?> get props => [folders, parentId];
}

class FoldersError extends FoldersState {
  final String message;

  const FoldersError({required this.message});

  @override
  List<Object?> get props => [message];
}
