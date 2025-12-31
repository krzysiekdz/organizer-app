import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/folder_model.dart';

abstract class FolderRemoteDataSource {
  Future<List<FolderModel>> getFolders(String userId);
  Future<List<FolderModel>> getFoldersByParentId(String userId, String? parentId);
  Future<FolderModel> createFolder(FolderModel folder);
  Future<void> updateFolder(FolderModel folder);
  Future<void> deleteFolder(String folderId);
  Future<FolderModel?> getFolderById(String folderId);
}

class FolderRemoteDataSourceImpl implements FolderRemoteDataSource {
  final FirebaseFirestore firestore;

  FolderRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<FolderModel>> getFolders(String userId) async {
    final querySnapshot = await firestore
        .collection('folders')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => FolderModel.fromFirestore(doc))
        .toList();
  }

  @override
  Future<List<FolderModel>> getFoldersByParentId(
      String userId, String? parentId) async {
    Query query = firestore
        .collection('folders')
        .where('userId', isEqualTo: userId);

    if (parentId == null) {
      query = query.where('parentId', isNull: true);
    } else {
      query = query.where('parentId', isEqualTo: parentId);
    }

    final querySnapshot = await query.orderBy('createdAt', descending: true).get();

    return querySnapshot.docs
        .map((doc) => FolderModel.fromFirestore(doc))
        .toList();
  }

  @override
  Future<FolderModel> createFolder(FolderModel folder) async {
    final docRef = firestore.collection('folders').doc();
    final folderWithId = FolderModel(
      id: docRef.id,
      name: folder.name,
      parentId: folder.parentId,
      userId: folder.userId,
      createdAt: folder.createdAt,
    );
    await docRef.set(folderWithId.toFirestore());
    return folderWithId;
  }

  @override
  Future<void> updateFolder(FolderModel folder) async {
    await firestore.collection('folders').doc(folder.id).update(
          folder.toFirestore(),
        );
  }

  @override
  Future<void> deleteFolder(String folderId) async {
    await firestore.collection('folders').doc(folderId).delete();
  }

  @override
  Future<FolderModel?> getFolderById(String folderId) async {
    final doc = await firestore.collection('folders').doc(folderId).get();
    if (!doc.exists) return null;
    return FolderModel.fromFirestore(doc);
  }
}

