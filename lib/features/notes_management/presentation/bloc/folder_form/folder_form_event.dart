part of 'folder_form_bloc.dart';

abstract class FolderFormEvent extends Equatable {
  const FolderFormEvent();

  @override
  List<Object?> get props => [];
}

class CreateFolderSubmitted extends FolderFormEvent {
  final String name;
  final String? parentId;

  const CreateFolderSubmitted({required this.name, this.parentId});

  @override
  List<Object?> get props => [name, parentId];
}

class UpdateFolderSubmitted extends FolderFormEvent {
  final Folder folder;

  const UpdateFolderSubmitted({required this.folder});

  @override
  List<Object?> get props => [folder];
}
