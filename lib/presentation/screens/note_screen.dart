import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notie/application/cubit/auth_cubit.dart';
import 'package:notie/application/cubit/notecubit_cubit.dart';
import 'package:notie/application/usecases/player.dart';
import 'package:notie/presentation/screens/audio_note_screen.dart';
import 'package:notie/presentation/screens/compose_note_screen.dart';
import 'package:notie/presentation/widgets/app_snackbar.dart';
import 'package:notie/presentation/widgets/audio_note_tile.dart';
import 'package:notie/presentation/widgets/custom_status_bar.dart';
import 'package:notie/presentation/widgets/text_note_tile.dart';
import 'package:notie/routes.dart';
import 'package:notie/utils/app_color.dart';
import 'package:notie/utils/enums.dart';
import 'package:notie/utils/extensions.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late TextEditingController _searchCtrl;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool onDrawer = true;
  @override
  void initState() {
    super.initState();
    context.read<NotecubitCubit>().loadNotes();
    _searchCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NotecubitCubit>();
    return CustomStatusBar(
      child: GestureDetector(
        onTap: () {
          cubit.clearSelections();
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: AppColor.mainColor,
          drawer: Drawer(
              backgroundColor: AppColor.mainColor,
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is SignedOut) {
                    Navigator.pushReplacementNamed(context, Routes.signIn);
                  }
                },
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: DrawerHeader(
                          child: Image.asset(
                            'asset/images/notie_header.png',
                            scale: 1.2,
                          ),
                        ),
                      ),
                      const Divider(color: AppColor.white),
                      const SizedBox(height: 80),
                      if (state is AuthUser && (state.hasAccount == false))
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, Routes.signUp);
                          },
                          child: const Text(
                            'Sign up',
                            style: TextStyle(
                                fontSize: 18.0, color: AppColor.white),
                          ),
                        ),
                      if (state is AuthUser && state.hasAccount == true)
                        TextButton(
                          onPressed: () {
                            context.read<AuthCubit>().signOut();
                          },
                          child: const Text(
                            'LogOut',
                            style: TextStyle(
                                fontSize: 18.0, color: AppColor.white),
                          ),
                        ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'About',
                          style:
                              TextStyle(fontSize: 18.0, color: AppColor.white),
                        ),
                      ),
                    ],
                  );
                },
              )),
          body: Container(
            height: double.maxFinite,
            width: double.maxFinite,
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Column(
              children: [
                SizedBox(height: context.barHeight),
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              //Scaffold.of(context).openDrawer();
                              _scaffoldKey.currentState!.openDrawer();
                            },
                            child: const ImageIcon(
                              AssetImage('asset/images/menu_button.png'),
                              color: AppColor.white,
                            ),
                          ),
                          const CircleAvatar(
                            backgroundColor: AppColor.white,
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<NotecubitCubit, NotecubitState>(
                      builder: (context, state) {
                        if (state is LoadNote) {
                          return AnimatedOpacity(
                            opacity: state.selections.isEmpty ? 0 : 1,
                            duration: const Duration(milliseconds: 200),
                            child: Container(
                              padding: const EdgeInsets.all(4.0),
                              width: MediaQuery.of(context).size.width,
                              color: const Color(0XFF264653),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          cubit.clearSelections();
                                        },
                                        icon: const Icon(Icons.close),
                                      ),
                                      Text(
                                        state.selections.length.toString(),
                                        style: const TextStyle(fontSize: 18.0),
                                      )
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      cubit.deleteNote();
                                    },
                                    icon: const Icon(Icons.delete),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Container(
                        height: 40,
                        padding: const EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          controller: _searchCtrl,
                          autofocus: false,
                          decoration: const InputDecoration(
                            hintText: 'search note',
                            border: InputBorder.none,
                            suffixIcon: Icon(Icons.mic),
                          ),
                          onChanged: (value) {
                            if (value.isEmpty) {
                              cubit.loadNotes();
                            }
                            cubit.searchNotes(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                BlocConsumer<NotecubitCubit, NotecubitState>(
                  listener: (context, state) {
                    if (state is SaveNote) {
                      if (state.success) {
                        AppSnackBar.success(context, 'Note Saved Successfully');
                      }
                    }
                    if (state is UpdateNote) {
                      if (state.updated) {
                        AppSnackBar.success(
                            context, 'Note Updated Successfully');
                      }
                    }
                  },
                  builder: (context, state) {
                    if (state is NoteLoading) {
                      return const Expanded(
                          child: Center(child: CircularProgressIndicator()));
                    } else if (state is SaveNote) {
                      return const SizedBox();
                    } else if (state is DeleteNote) {
                      return const SizedBox();
                    } else if (state is UpdateNote) {
                      return const SizedBox();
                    }

                    LoadNote note = state as LoadNote;
                    if (note.notes.isEmpty) {
                      return const Expanded(
                        child: Center(
                          child: Text(
                            'No available notes',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: MasonryGridView.builder(
                          padding: const EdgeInsets.only(top: 20),
                          physics: const BouncingScrollPhysics(),
                          itemCount: note.notes.length,
                          mainAxisSpacing: 6.0,
                          crossAxisSpacing: 6.0,
                          gridDelegate:
                              const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            if (note.notes[index].noteType == NoteType.audio) {
                              return AudioNoteTile(note: note.notes[index]);
                            }
                            return TextNoteTile(
                                note: note.notes[index],
                                selections: note.selections);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: context.openKeyboard
              ? FloatingActionButton(
                  backgroundColor: const Color(0XFF264653),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.composeNote);
                  },
                  child: const Icon(Icons.create),
                )
              : null,
        ),
      ),
    );
  }
}
