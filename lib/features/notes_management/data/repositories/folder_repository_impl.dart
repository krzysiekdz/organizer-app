import '../../domain/entities/folder.dart';
import '../../domain/repositories/folder_repository.dart';
import '../datasources/folder_remote_datasource.dart';

class FolderRepositoryImpl implements FolderRepository {
  final FolderRemoteDataSource remoteDataSource;

  FolderRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Folder>> getFoldersByParentId(String userId, String? parentId) async {
    return await remoteDataSource.getFoldersByParentId(userId, parentId);
  }

  @override
  Stream<List<Folder>> watchFolders(String userId, String? parentId) {
    return remoteDataSource.watchFolders(userId, parentId);
  }

  @override
  Future<Folder> createFolder(Folder folder) async {
    return await remoteDataSource.createFolder(folder);
  }

  @override
  Future<void> updateFolder(Folder folder) async {
    await remoteDataSource.updateFolder(folder);
  }

  @override
  Future<void> deleteFolder(String folderId) async {
    await remoteDataSource.deleteFolder(folderId);
  }

  @override
  Future<Folder?> getFolderById(String folderId) async {
    return await remoteDataSource.getFolderById(folderId);
  }
}
