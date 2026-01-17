import '../entities/auth_failure.dart';
import '../repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  Future<AuthFailure?> call() async {
    try {
      await repository.signOut();
      return null; // Success
    } catch (e) {
      return NetworkFailure(e.toString());
    }
  }
}

