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

class LoggedIn extends AuthState {
  @override
  List<Object> get props => [];
}

class SignedOut extends AuthState {
  @override
  List<Object> get props => [];
}
