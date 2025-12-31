import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

abstract class AuthRemoteDataSource {
  Future<String?> signInWithEmailAndPassword(String email, String password);
  Future<String?> signUpWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Stream<String?> get authStateChanges;
  String? get currentUserId;
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final firebase_auth.FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl(this.firebaseAuth);

  @override
  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user?.uid;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user?.uid;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Stream<String?> get authStateChanges {
    return firebaseAuth.authStateChanges().map((user) => user?.uid);
  }

  @override
  String? get currentUserId => firebaseAuth.currentUser?.uid;
}

