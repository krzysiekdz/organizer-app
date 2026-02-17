import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/folder.dart';

class FolderModel {
  FolderModel._();

  static Folder fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Folder(
      id: doc.id,
      name: data['name'] as String,
      parentId: data['parentId'] as String?,
      userId: data['userId'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  static Map<String, dynamic> toFirestore(Folder folder) {
    return {
      'name': folder.name,
      'parentId': folder.parentId,
      'userId': folder.userId,
      'createdAt': Timestamp.fromDate(folder.createdAt),
    };
  }
}
