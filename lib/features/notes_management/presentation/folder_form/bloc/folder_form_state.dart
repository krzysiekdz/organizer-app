part of 'folder_form_bloc.dart';

abstract class FolderFormState extends Equatable {
  const FolderFormState();

  @override
  List<Object?> get props => [];
}

class FolderFormInitial extends FolderFormState {}

class FolderFormLoading extends FolderFormState {}

class FolderFormSuccess extends FolderFormState {}

class FolderFormError extends FolderFormState {
  final String message;

  const FolderFormError({required this.message});

  @override
  List<Object?> get props => [message];
}
