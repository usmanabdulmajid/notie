import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notie/exceptions/auth_exceptions.dart';
import 'package:notie/service/auth/iauthentication.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IAuthentication authentication;
  AuthCubit(this.authentication) : super(AuthLoading());

  Future<void> loadDetails() async {
    await Future.delayed(const Duration(seconds: 1));
    final result = await authentication.authPersistState();
    if (result) {
      emit(SignedIn());
    } else {
      emit(SignIn());
    }
  }

  Future<void> authState() async {
    final result = await authentication.authPersistState();
    if (result) {
      emit(AuthUser(result));
    } else {
      (emit(AuthUser(result)));
    }
  }

  Future<void> signUpWithEmail(String email, String password) async {
    try {
      final result = await authentication.signUpWithEmail(
          email: email, password: password);
      if (result) {
        emit(SignedIn());
        authState();
      }
    } on EmailAlreadyExist catch (e) {
      emit(EmailAlreadyInUse(e.message));
    } on WeakPassword catch (e) {
      emit(PasswordIsWeak(e.message));
    }
  }

  Future<void> loginWithEmail(String email, String password) async {
    try {
      final result =
          await authentication.logInWithEmail(email: email, password: password);
      if (result) {
        emit(SignedIn());
        authState();
      }
    } on UserNotFound catch (e) {
      emit(InvalidUser(e.message));
    } on WrongPassWord catch (e) {
      emit(InvalidPassword(e.message));
    }
  }

  Future<void> signOut() async {
    final result = await authentication.signOut();
    if (result) {
      emit(SignedOut());
    }
    authState();
  }
}
