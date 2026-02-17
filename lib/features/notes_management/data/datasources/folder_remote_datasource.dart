import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/folder.dart';
import '../models/folder_model.dart';

abstract interface class FolderRemoteDataSource {
  Future<List<Folder>> getFoldersByParentId(String userId, String? parentId);
  Stream<List<Folder>> watchFolders(String userId, String? parentId);
  Future<Folder> createFolder(Folder folder);
  Future<void> updateFolder(Folder folder);
  Future<void> deleteFolder(String folderId);
  Future<Folder?> getFolderById(String folderId);
}

final class FolderRemoteDataSourceImpl implements FolderRemoteDataSource {
  final FirebaseFirestore firestore;

  FolderRemoteDataSourceImpl(this.firestore);

  @override
  Future<List<Folder>> getFoldersByParentId(
    String userId,
    String? parentId,
  ) async {
    Query query = firestore
        .collection('folders')
        .where('userId', isEqualTo: userId);

    if (parentId == null) {
      query = query.where('parentId', isNull: true);
    } else {
      query = query.where('parentId', isEqualTo: parentId);
    }

    final querySnapshot = await query
        .orderBy('createdAt', descending: true)
        .get();

    return querySnapshot.docs
        .map((doc) => FolderModel.fromFirestore(doc))
        .toList();
  }

  @override
  Stream<List<Folder>> watchFolders(String userId, String? parentId) {
    Query query = firestore
        .collection('folders')
        .where('userId', isEqualTo: userId);

    if (parentId == null) {
      query = query.where('parentId', isNull: true);
    } else {
      query = query.where('parentId', isEqualTo: parentId);
    }

    return query.snapshots().map((snapshot) {
      final list = snapshot.docs
          .map((doc) => FolderModel.fromFirestore(doc))
          .toList();
      list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return list;
    });
  }

  @override
  Future<Folder> createFolder(Folder folder) async {
    final docRef = firestore.collection('folders').doc();
    await docRef.set(FolderModel.toFirestore(folder));
    return FolderModel.fromFirestore(await docRef.get());
  }

  @override
  Future<void> updateFolder(Folder folder) async {
    await firestore
        .collection('folders')
        .doc(folder.id)
        .update(FolderModel.toFirestore(folder));
  }

  @override
  Future<void> deleteFolder(String folderId) async {
    await firestore.collection('folders').doc(folderId).delete();
  }

  @override
  Future<Folder?> getFolderById(String folderId) async {
    final doc = await firestore.collection('folders').doc(folderId).get();
    if (!doc.exists) return null;
    return FolderModel.fromFirestore(doc);
  }
}
