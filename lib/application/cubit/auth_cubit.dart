import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notie/domain/usecases/iauthentication.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IAuthentication authentication;
  AuthCubit(this.authentication) : super(AuthLoading());

  Future<void> loadDetails() async {
    final result = await authentication.authPersistState();
    if (result) {
      emit(SignedIn());
    } else {
      emit(SignIn());
    }
  }

  Future signUpWithEmail(String email, String password) async {
    final result =
        await authentication.signUpWithEmail(email: email, password: password);

    return result;
  }
}
