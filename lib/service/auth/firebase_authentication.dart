import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notie/common/exceptions/auth_exceptions.dart';
import 'package:notie/service/auth/iauthentication.dart';

class FirebaseAuthImp implements IAuthentication {
  final FirebaseAuth firebaseAuth;
  FirebaseAuthImp(this.firebaseAuth);

  @override
  Future<bool> signUpWithEmail(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPassword('provide a stronger password');
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyExist('email already existed');
      }
    } catch (e) {
      //print(e);
    }
    return firebaseAuth.currentUser != null;
  }

  @override
  Future<bool> logInWithEmail(
      {required String email, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFound('user does not exist');
      } else if (e.code == 'wrong-password') {
        throw WrongPassWord('Invalid password');
      }
    }
    return firebaseAuth.currentUser != null;
  }

  @override
  Future<bool> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await firebaseAuth.signInWithCredential(credential);
    return firebaseAuth.currentUser != null;
  }

  @override
  Future<bool> signInWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();
    final credential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    await firebaseAuth.signInWithCredential(credential);
    return firebaseAuth.currentUser != null;
  }

  @override
  Future<bool> signOut() async {
    await firebaseAuth.signOut();
    return firebaseAuth.currentUser == null;
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
