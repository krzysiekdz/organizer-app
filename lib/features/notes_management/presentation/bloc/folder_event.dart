part of 'folder_bloc.dart';

abstract class FolderEvent extends Equatable {
  const FolderEvent();

  @override
  List<Object?> get props => [];
}

class LoadFolders extends FolderEvent {
  const LoadFolders();
}

class LoadFoldersByParentId extends FolderEvent {
  final String? parentId;

  const LoadFoldersByParentId({required this.parentId});

  @override
  List<Object?> get props => [parentId];
}

class CreateFolder extends FolderEvent {
  final String name;
  final String? parentId;

  const CreateFolder({
    required this.name,
    this.parentId,
  });

  @override
  List<Object?> get props => [name, parentId];
}

class UpdateFolder extends FolderEvent {
  final Folder folder;

  const UpdateFolder({required this.folder});

  @override
  List<Object?> get props => [folder];
}

class DeleteFolder extends FolderEvent {
  final String folderId;

  const DeleteFolder({required this.folderId});

  @override
  List<Object?> get props => [folderId];
}

/// Fired when the folders collection changes (e.g. from another device).
class FoldersChanged extends FolderEvent {
  final List<Folder> folders;

  const FoldersChanged({required this.folders});

  @override
  List<Object?> get props => [folders];
}

