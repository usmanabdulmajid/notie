import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notie/domain/usecases/iauthentication.dart';

class FirebaseAuthImp implements IAuthentication {
  final FirebaseAuth firebaseAuth;
  FirebaseAuthImp(this.firebaseAuth);
  @override
  Future signInWithEmail(
      {required String email, required String password}) async {
    UserCredential userCredential;

    try {
      userCredential = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('user not found');
      } else if (e.code == 'wrong password') {
        print('wrong password');
      }
    }
  }

  @override
  Future<bool> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future signUpWithEmail(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      print(userCredential);
      print('shikai');
    } on FirebaseAuthException catch (e) {
      print('zangetsu');
      print(e);
      if (e.code == 'weak-password') {
        print('week password');
      } else if (e.code == 'email-already-in-use') {
        print('email laready in use');
      }
    } catch (e) {
      print(e);
    }
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
}
