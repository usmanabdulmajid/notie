import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:notie/service/auth/firebase_authentication.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<FirebaseAuthImp>(
      () => FirebaseAuthImp(FirebaseAuth.instance));
}
