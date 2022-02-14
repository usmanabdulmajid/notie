part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class SignIn extends AuthState {
  @override
  List<Object> get props => [];
}

class SignedIn extends AuthState {
  @override
  List<Object> get props => [];
}

class SignedOut extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthUser extends AuthState {
  final bool hasAccount;
  const AuthUser(this.hasAccount);
  @override
  List<Object> get props => [hasAccount];
}

class InvalidPassword extends AuthState {
  final String message;
  const InvalidPassword(this.message);
  @override
  List<Object> get props => [message];
}

class InvalidUser extends AuthState {
  final String message;
  const InvalidUser(this.message);
  @override
  List<Object> get props => [message];
}

class EmailAlreadyInUse extends AuthState {
  final String message;
  const EmailAlreadyInUse(this.message);
  @override
  List<Object> get props => [message];
}

class PasswordIsWeak extends AuthState {
  final String message;
  const PasswordIsWeak(this.message);
  @override
  List<Object> get props => [message];
}
