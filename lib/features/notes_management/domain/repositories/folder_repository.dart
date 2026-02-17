import '../entities/folder.dart';

abstract class FolderRepository {
  Future<List<Folder>> getFoldersByParentId(String userId, String? parentId);
  Stream<List<Folder>> watchFolders(String userId, String? parentId);
  Future<Folder> createFolder(Folder folder);
  Future<void> updateFolder(Folder folder);
  Future<void> deleteFolder(String folderId);
  Future<Folder?> getFolderById(String folderId);
}

