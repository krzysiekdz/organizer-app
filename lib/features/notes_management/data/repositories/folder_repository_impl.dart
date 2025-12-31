import '../../domain/entities/folder.dart';
import '../../domain/repositories/folder_repository.dart';
import '../datasources/folder_remote_datasource.dart';
import '../models/folder_model.dart';

class FolderRepositoryImpl implements FolderRepository {
  final FolderRemoteDataSource remoteDataSource;

  FolderRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Folder>> getFolders(String userId) async {
    return await remoteDataSource.getFolders(userId);
  }

  @override
  Future<List<Folder>> getFoldersByParentId(String userId, String? parentId) async {
    return await remoteDataSource.getFoldersByParentId(userId, parentId);
  }

  @override
  Future<Folder> createFolder(Folder folder) async {
    final folderModel = FolderModel.fromEntity(folder);
    return await remoteDataSource.createFolder(folderModel);
  }

  @override
  Future<void> updateFolder(Folder folder) async {
    final folderModel = FolderModel.fromEntity(folder);
    await remoteDataSource.updateFolder(folderModel);
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

