abstract class IAuthentication {
  Future<bool> signUpWithEmail(
      {required String email, required String password});
  Future<bool> logInWithEmail(
      {required String email, required String password});
  Future<bool> authPersistState();
  Future<bool> signInWithGoogle();
  Future<void> signOut();
}
