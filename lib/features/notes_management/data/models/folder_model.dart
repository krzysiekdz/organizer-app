import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/folder.dart';

class FolderModel extends Folder {
  const FolderModel({
    required super.id,
    required super.name,
    super.parentId,
    required super.userId,
    required super.createdAt,
  });

  factory FolderModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FolderModel(
      id: doc.id,
      name: data['name'] as String,
      parentId: data['parentId'] as String?,
      userId: data['userId'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'parentId': parentId,
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory FolderModel.fromEntity(Folder folder) {
    return FolderModel(
      id: folder.id,
      name: folder.name,
      parentId: folder.parentId,
      userId: folder.userId,
      createdAt: folder.createdAt,
    );
  }

  Folder toEntity() {
    return Folder(
      id: id,
      name: name,
      parentId: parentId,
      userId: userId,
      createdAt: createdAt,
    );
  }
}

