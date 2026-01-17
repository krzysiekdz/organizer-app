sealed class AuthFailure {
  final String message;
  
  const AuthFailure(this.message);
  
  @override
  String toString() => message;
}

class ValidationFailure extends AuthFailure {
  const ValidationFailure(super.message);
}

class NetworkFailure extends AuthFailure {
  const NetworkFailure(super.message);
}

class AuthOperationFailure extends AuthFailure {
  const AuthOperationFailure(super.message);
}

