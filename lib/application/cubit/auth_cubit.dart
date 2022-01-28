import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notie/domain/usecases/iauthentication.dart';

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
    final result =
        await authentication.signUpWithEmail(email: email, password: password);
    if (result) {
      emit(SignedIn());
      authState();
    }
  }

  Future<void> loginWithEmail(String email, String password) async {
    final result =
        await authentication.logInWithEmail(email: email, password: password);
    if (result) {
      emit(SignedIn());
      authState();
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
