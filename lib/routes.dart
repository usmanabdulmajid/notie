import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notie/domain/models/note.dart';
import 'package:notie/presentation/screens/audio_note_screen.dart';
import 'package:notie/presentation/screens/compose_note_screen.dart';
import 'package:notie/presentation/screens/create_account_screen.dart';
import 'package:notie/presentation/screens/note_screen.dart';
import 'package:notie/presentation/screens/read_note_screen.dart';
import 'package:notie/presentation/screens/sign_in_screen.dart';
import 'package:notie/presentation/screens/sign_up_screen.dart';

class Routes {
  static const signUp = '/sign-up';
  static const signIn = '/sign-in';
  static const createAccount = '/create-account';
  static const audio = '/audio';
  static const readNote = '/read-note';
  static const composeNote = '/compose-note';
  static const home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case createAccount:
        return MaterialPageRoute(builder: (_) => const CreateAccountScreen());
      case audio:
        return MaterialPageRoute(builder: (_) => const AudioNoteScreen());
      case readNote:
        final note = settings.arguments as Note;
        return MaterialPageRoute(builder: (_) => ReadNoteScreen(note: note));
      case composeNote:
        final note = settings.arguments as Note?;
        return MaterialPageRoute(builder: (_) => ComposeNoteScreen(note: note));
      case home:
        return MaterialPageRoute(builder: (_) => const NoteScreen());
      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text('no route found'),
              ),
            );
          },
        );
    }
  }
}
