abstract class AuthRepository {
  Future<String?> signInWithEmailAndPassword(String email, String password);
  Future<String?> signUpWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Stream<String?> get authStateChanges;
  String? get currentUserId;
}

