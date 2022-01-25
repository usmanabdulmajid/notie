import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:notie/application/cubit/auth_cubit.dart';
import 'package:notie/application/cubit/notecubit_cubit.dart';
import 'package:notie/application/usecases/firebase_authentication.dart';
import 'package:notie/infrastructure/datasource/sql_local_datasource.dart';
import 'package:notie/infrastructure/repositories/note_repository.dart';
import 'package:notie/infrastructure/repositories/recorder_repository.dart';
import 'package:notie/presentation/screens/audio_note_screen.dart';
import 'package:notie/presentation/screens/launch_screen.dart';
import 'package:notie/routes.dart';

import 'application/cubit/recoder_cubit.dart';
import 'application/usecases/recoder.dart';
import 'presentation/screens/compose_note_screen.dart';
import 'presentation/screens/note_screen.dart';
import 'presentation/screens/read_note_screen.dart';
import 'presentation/screens/sign_up_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
              SqlLocalDatasource(),
            ),
          ),
        ),
        BlocProvider<RecoderCubit>(
          create: (context) => RecoderCubit(
            RecorderRepository(
              Recoder(
                FlutterSoundRecorder(),
              ),
            ),
          ),
        ),
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(
            FirebaseAuthImp(FirebaseAuth.instance),
          ),
        )
      ],
      child: MaterialApp(
        title: 'Notie',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const LaunchScreen(),
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
