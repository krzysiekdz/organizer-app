import '../entities/auth_failure.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import '../services/email_validator_service.dart';
import '../services/password_validator_service.dart';

class SignInUseCase {
  final AuthRepository repository;
  final EmailValidatorService emailValidator;
  final PasswordValidatorService passwordValidator;

  SignInUseCase(
    this.repository, {
    EmailValidatorService? emailValidator,
    PasswordValidatorService? passwordValidator,
  }) : emailValidator = emailValidator ?? EmailValidatorServiceImpl(),
       passwordValidator = passwordValidator ?? PasswordValidatorServiceImpl();

  Future<({AuthFailure? failure, User? user})> call(
    String email,
    String password,
  ) async {
    // Business rule: Validate email
    final emailError = emailValidator.validate(email);
    if (emailError != null) {
      return (failure: ValidationFailure(emailError), user: null);
    }

    // Business rule: Validate password
    final passwordError = passwordValidator.validate(password);
    if (passwordError != null) {
      return (failure: ValidationFailure(passwordError), user: null);
    }

    // Business rule: Attempt sign in
    try {
      final user = await repository.signInWithEmailAndPassword(email, password);

      if (user == null) {
        return (
          failure: const AuthOperationFailure('Sign in failed'),
          user: null,
        );
      }

      return (failure: null, user: user);
    } catch (e) {
      return (failure: NetworkFailure(e.toString()), user: null);
    }
  }
}
