import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notie/cubit/auth_cubit.dart';
import 'package:notie/cubit/notecubit_cubit.dart';
import 'package:notie/repositories/note_repository.dart';
import 'package:notie/service/auth/firebase_authentication.dart';
import 'package:notie/service/local_db/sql_local_datasource.dart';
import 'package:notie/service/remote_db/firestore_database.dart';
import 'package:notie/injection_container.dart';
import 'package:notie/presentation/screens/launch_screen.dart';
import 'package:notie/routes.dart';
import 'package:notie/utils/app_color.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NotecubitCubit>(
          create: (context) => NotecubitCubit(
            NoteRepository(
                localDatasource: SqlLocalDatasource(),
                remoteDatabase: FirestoreDatabase(
                    FirebaseFirestore.instance.collection('notes'))),
          ),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(
            FirebaseAuthImp(FirebaseAuth.instance),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Notie',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            scaffoldBackgroundColor: AppColor.mainColor,
            primarySwatch: Colors.blue,
            fontFamily: 'SupermercadoOne'),
        home: const LaunchScreen(),
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
