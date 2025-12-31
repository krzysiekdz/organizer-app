import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    return await remoteDataSource.signInWithEmailAndPassword(email, password);
  }

  @override
  Future<String?> signUpWithEmailAndPassword(
      String email, String password) async {
    return await remoteDataSource.signUpWithEmailAndPassword(email, password);
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
  }

  @override
  Stream<String?> get authStateChanges => remoteDataSource.authStateChanges;

  @override
  String? get currentUserId => remoteDataSource.currentUserId;
}

