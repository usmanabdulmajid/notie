import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notie/domain/usecases/iauthentication.dart';

class FirebaseAuthImp implements IAuthentication {
  final FirebaseAuth firebaseAuth;
  FirebaseAuthImp(this.firebaseAuth);
  @override
  Future<bool> logInWithEmail(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
      } else if (e.code == 'wrong password') {}
    }
    return firebaseAuth.currentUser != null;
  }

  @override
  Future<bool> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<bool> signOut() async {
    await firebaseAuth.signOut();
    return firebaseAuth.currentUser == null;
  }

  @override
  Future<bool> signUpWithEmail(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
      } else if (e.code == 'email-already-in-use') {}
    } catch (e) {
      //print(e);
    }
    return firebaseAuth.currentUser != null;
  }

  @override
  Future<bool> authPersistState() async {
    User? user = firebaseAuth.currentUser;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  String? userId() {
    return firebaseAuth.currentUser?.uid;
  }
}
