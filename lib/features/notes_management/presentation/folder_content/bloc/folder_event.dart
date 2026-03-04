part of 'folder_bloc.dart';

abstract class FolderContentEvent extends Equatable {
  const FolderContentEvent();

  @override
  List<Object?> get props => [];
}

class RefreshFolderContent extends FolderContentEvent {
  const RefreshFolderContent();
}

class FolderContentErrorOccured extends FolderContentEvent {
  final String message;

  const FolderContentErrorOccured({required this.message});

  @override
  List<Object?> get props => [message];
}

enum FolderContentType { folder, note }

class FolderContentDelete extends FolderContentEvent {
  final String id;
  final FolderContentType type;

  const FolderContentDelete({required this.id, required this.type});

  @override
  List<Object?> get props => [id, type];
}

/// Fired when the folders collection changes (e.g. from another device).
class FolderContentChanged extends FolderContentEvent {
  final List<Folder> folders;
  final List<Note> notes;

  const FolderContentChanged({required this.folders, required this.notes});

  @override
  List<Object?> get props => [folders, notes];
}
