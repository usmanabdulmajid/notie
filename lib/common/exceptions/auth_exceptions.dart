abstract class AuthException implements Exception {
  final String message;
  const AuthException(this.message);
}

class UserNotFound extends AuthException {
  UserNotFound(String message) : super(message);
}

class WrongPassWord extends AuthException {
  WrongPassWord(String message) : super(message);
}

class WeakPassword extends AuthException {
  WeakPassword(String message) : super(message);
}

class EmailAlreadyExist extends AuthException {
  EmailAlreadyExist(String message) : super(message);
}
