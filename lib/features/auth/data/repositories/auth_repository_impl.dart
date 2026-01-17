import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../datasources/auth_local_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final user = await remoteDataSource.signInWithEmailAndPassword(
      email,
      password,
    );
    // Cache user locally after successful sign in
    if (user != null) {
      await localDataSource.cacheUser(user);
    }
    return user;
  }

  @override
  Future<User?> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final user = await remoteDataSource.signUpWithEmailAndPassword(
      email,
      password,
    );
    // Cache user locally after successful sign up
    if (user != null) {
      await localDataSource.cacheUser(user);
    }
    return user;
  }

  @override
  Future<void> signOut() async {
    await remoteDataSource.signOut();
    // Clear local cache when signing out
    await localDataSource.clearCache();
  }

  @override
  Stream<User?> get authStateChanges => remoteDataSource.authStateChanges;

  @override
  User? get currentUser {
    // Try local cache first (fast, works offline)
    final cachedUser = localDataSource.getCachedUser();
    if (cachedUser != null) {
      return cachedUser;
    }
    // Fallback to remote if no cache
    return remoteDataSource.currentUser;
  }
}
