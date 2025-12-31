import 'package:equatable/equatable.dart';

enum NoteType {
  text,
  todo,
  list,
}

abstract class Note extends Equatable {
  final String id;
  final String name;
  final String? folderId;
  final String userId;
  final NoteType type;
  final DateTime createdAt;

  const Note({
    required this.id,
    required this.name,
    this.folderId,
    required this.userId,
    required this.type,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, name, folderId, userId, type, createdAt];
}

