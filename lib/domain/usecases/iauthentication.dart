abstract class IAuthentication {
  Future signUpWithEmail({required String email, required String password});
  Future signInWithEmail({required String email, required String password});
  Future<bool> authPersistState();
  Future<bool> signInWithGoogle();
  Future<void> signOut();
}
