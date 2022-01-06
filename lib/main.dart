import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notie/application/cubit/notecubit_cubit.dart';
import 'package:notie/infrastructure/datasource/sql_local_datasource.dart';
import 'package:notie/infrastructure/repositories/note_repository.dart';

import 'presentation/screens/compose_note_screen.dart';
import 'presentation/screens/note_screen.dart';
import 'presentation/screens/read_note_screen.dart';
import 'presentation/screens/sign_up_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotecubitCubit>(
      create: (context) => NotecubitCubit(NoteRepository(SqlLocalDatasource())),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NoteScreen(),
      ),
    );
  }
}
