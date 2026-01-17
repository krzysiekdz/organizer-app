abstract interface class EmailValidatorService {
  /// Validates if the email is not empty
  bool isEmpty(String email);

  /// Validates if the email format is correct
  bool isValidFormat(String email);

  /// Validates email and returns error message if invalid
  String? validate(String email);

  /// Validates email and returns detailed validation result
  EmailValidationResult validateDetailed(String email);
}

class EmailValidatorServiceImpl implements EmailValidatorService {
  // RFC 5322 compliant email regex (simplified but effective)
  static final RegExp _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  bool isEmpty(String email) {
    return email.trim().isEmpty;
  }

  @override
  bool isValidFormat(String email) {
    if (isEmpty(email)) return false;
    return _emailRegex.hasMatch(email.trim());
  }

  @override
  String? validate(String email) {
    if (isEmpty(email)) {
      return 'Email cannot be empty';
    }

    if (!isValidFormat(email)) {
      return 'Invalid email format';
    }

    return null; // Valid
  }

  @override
  EmailValidationResult validateDetailed(String email) {
    if (isEmpty(email)) {
      return EmailValidationResult(
        isValid: false,
        error: 'Email cannot be empty',
      );
    }

    if (!isValidFormat(email)) {
      return EmailValidationResult(
        isValid: false,
        error: 'Invalid email format. Please enter a valid email address.',
      );
    }

    return EmailValidationResult(isValid: true);
  }
}

class EmailValidationResult {
  final bool isValid;
  final String? error;

  const EmailValidationResult({required this.isValid, this.error});
}
