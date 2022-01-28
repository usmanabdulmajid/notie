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
