import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../models/user_model.dart';
import '../../domain/entities/user.dart';

// interfejs należałoby wydzielić do osobnego pliku, a implementację do osobnego pliku.

abstract class AuthRemoteDataSource {
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> signUpWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Stream<User?> get authStateChanges;
  User? get currentUser;
}

// potem zaimplementujem logowanie przez Google, Facebook, Apple, etc.

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final firebase_auth.FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImpl(this.firebaseAuth);

  @override
  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final firebaseUser = userCredential.user;
      if (firebaseUser == null) return null;
      return UserModel.fromFirebaseUser(firebaseUser);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User?> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final firebaseUser = userCredential.user;
      if (firebaseUser == null) return null;
      return UserModel.fromFirebaseUser(firebaseUser);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Stream<User?> get authStateChanges {
    return firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) return null;
      return UserModel.fromFirebaseUser(firebaseUser);
    });
  }

  @override
  User? get currentUser {
    final firebaseUser = firebaseAuth.currentUser;
    if (firebaseUser == null) return null;
    return UserModel.fromFirebaseUser(firebaseUser);
  }
}
