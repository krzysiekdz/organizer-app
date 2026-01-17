abstract interface class PasswordValidatorService {
  /// Validates if the password is not empty
  bool isEmpty(String password);

  /// Validates if the password meets minimum length requirement
  bool meetsMinLength(String password, int minLength);

  /// Validates password and returns error message if invalid
  String? validate(String password);

  /// Validates password with custom minimum length
  String? validateWithMinLength(String password, int minLength);

  /// Validates password and returns detailed validation result
  PasswordValidationResult validateDetailed(String password);

  /// Gets password strength (weak, medium, strong)
  PasswordStrength getStrength(String password);
}

class PasswordValidatorServiceImpl implements PasswordValidatorService {
  static const int defaultMinLength = 6;

  @override
  bool isEmpty(String password) {
    return password.isEmpty;
  }

  @override
  bool meetsMinLength(String password, int minLength) {
    return password.length >= minLength;
  }

  @override
  String? validate(String password) {
    return validateWithMinLength(password, defaultMinLength);
  }

  @override
  String? validateWithMinLength(String password, int minLength) {
    if (isEmpty(password)) {
      return 'Password cannot be empty';
    }

    if (!meetsMinLength(password, minLength)) {
      return 'Password must be at least $minLength characters';
    }

    return null; // Valid
  }

  @override
  PasswordValidationResult validateDetailed(String password) {
    if (isEmpty(password)) {
      return PasswordValidationResult(
        isValid: false,
        error: 'Password cannot be empty',
        strength: PasswordStrength.weak,
      );
    }

    if (!meetsMinLength(password, defaultMinLength)) {
      return PasswordValidationResult(
        isValid: false,
        error: 'Password must be at least $defaultMinLength characters',
        strength: PasswordStrength.weak,
      );
    }

    final strength = getStrength(password);

    return PasswordValidationResult(isValid: true, strength: strength);
  }

  @override
  PasswordStrength getStrength(String password) {
    if (password.length < 6) {
      return PasswordStrength.weak;
    }

    if (password.length < 8) {
      return PasswordStrength.medium;
    }

    // Check for complexity
    final hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    final hasLowerCase = password.contains(RegExp(r'[a-z]'));
    final hasNumbers = password.contains(RegExp(r'[0-9]'));
    final hasSpecialChars = password.contains(
      RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
    );

    final complexityScore = [
      hasUpperCase,
      hasLowerCase,
      hasNumbers,
      hasSpecialChars,
    ].where((e) => e).length;

    if (password.length >= 12 && complexityScore >= 3) {
      return PasswordStrength.strong;
    }

    if (password.length >= 8 && complexityScore >= 2) {
      return PasswordStrength.medium;
    }

    return PasswordStrength.weak;
  }
}

class PasswordValidationResult {
  final bool isValid;
  final String? error;
  final PasswordStrength strength;

  const PasswordValidationResult({
    required this.isValid,
    this.error,
    this.strength = PasswordStrength.weak,
  });
}

enum PasswordStrength { weak, medium, strong }
