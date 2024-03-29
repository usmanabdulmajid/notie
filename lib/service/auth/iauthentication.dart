abstract class IAuthentication {
  Future<bool> signUpWithEmail(
      {required String email, required String password});
  Future<bool> logInWithEmail(
      {required String email, required String password});
  String? userId();
  Future<bool> authPersistState();
  Future<bool> signInWithGoogle();
  Future<bool> signInWithFacebook();
  Future<bool> signOut();
}
