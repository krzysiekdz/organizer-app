import 'package:equatable/equatable.dart';

class Folder extends Equatable {
  final String id;
  final String name;
  final String? parentId;
  final String userId;
  final DateTime createdAt;

  const Folder({
    required this.id,
    required this.name,
    this.parentId,
    required this.userId,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, name, parentId, userId, createdAt];
}

