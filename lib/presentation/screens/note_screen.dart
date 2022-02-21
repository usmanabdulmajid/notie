import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notie/common/utils/app_color.dart';
import 'package:notie/cubit/auth_cubit.dart';
import 'package:notie/cubit/notecubit_cubit.dart';
import 'package:notie/presentation/widgets/app_snackbar.dart';
import 'package:notie/presentation/widgets/audio_note_tile.dart';
import 'package:notie/presentation/widgets/text_note_tile.dart';
import 'package:notie/routes.dart';
import 'package:notie/common/utils/enums.dart';
import 'package:notie/common/utils/extensions.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late TextEditingController _searchCtrl;
  final _key = GlobalKey<ScaffoldState>();
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
    return GestureDetector(
      onTap: () {
        cubit.clearSelections();
        FocusScope.of(context).unfocus();
      },
      child: BlocConsumer<NotecubitCubit, NotecubitState>(
        listener: (context, state) {
          if (state is SaveNote) {
            if (state.success) {
              AppSnackBar.success(context, 'Note Saved Successfully');
            }
          }
          if (state is UpdateNote) {
            if (state.updated) {
              AppSnackBar.success(context, 'Note Updated Successfully');
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            key: _key,
            appBar: AppBar(
              foregroundColor:
                  (state is LoadNote && state.selections.isNotEmpty)
                      ? Colors.black
                      : Colors.white,
              backgroundColor:
                  (state is LoadNote && state.selections.isNotEmpty)
                      ? const Color(0XFF264653)
                      : AppColor.mainColor,
              elevation: 0.0,
              leadingWidth: 40,
              leading: (state is LoadNote && state.selections.isNotEmpty)
                  ? GestureDetector(
                      onTap: () {
                        cubit.clearSelections();
                      },
                      child: const Icon(Icons.close),
                    )
                  : GestureDetector(
                      onTap: () {
                        _key.currentState!.openDrawer();
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 16.0),
                        child: ImageIcon(
                          AssetImage('asset/images/menu_button.png'),
                          size: 24,
                          color: AppColor.white,
                        ),
                      ),
                    ),
              titleSpacing: 0.0,
              title: (state is LoadNote && state.selections.isNotEmpty)
                  ? Text(state.selections.length.toString())
                  : null,
              actions: [
                (state is LoadNote && state.selections.length == 1)
                    ? IconButton(
                        onPressed: () {
                          cubit.shareNote();
                        },
                        icon: const Icon(Icons.share),
                      )
                    : const SizedBox(),
                (state is LoadNote && state.selections.isNotEmpty)
                    ? IconButton(
                        onPressed: () {
                          cubit.deleteNote();
                        },
                        icon: const Icon(Icons.delete),
                      )
                    : const Padding(
                        padding: EdgeInsets.only(
                          right: 16,
                        ),
                        child: CircleAvatar(
                          backgroundColor: AppColor.white,
                        ),
                      ),
              ],
            ),
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
                      const Center(
                        child: DrawerHeader(
                          child: Text(
                            'Notie',
                            style:
                                TextStyle(fontSize: 80, color: AppColor.white),
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
                            context.read<NotecubitCubit>().resetTable();
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
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                width: context.width,
                height: context.height,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: TextField(
                              controller: _searchCtrl,
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
                    if (state is NoteLoading)
                      const Expanded(
                          child: Center(
                              child: SpinKitCircle(color: AppColor.white))),
                    if (state is SaveNote) const SizedBox(),
                    if (state is DeleteNote) const SizedBox(),
                    if (state is UpdateNote) const SizedBox(),
                    if (state is LoadNote && state.notes.isEmpty)
                      const Expanded(
                          child: Center(
                              child: Text('No available notes',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)))),
                    if (state is LoadNote && state.notes.isNotEmpty)
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: MasonryGridView.builder(
                            padding: const EdgeInsets.only(top: 20),
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.notes.length,
                            mainAxisSpacing: 6.0,
                            crossAxisSpacing: 6.0,
                            gridDelegate:
                                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, index) {
                              return TextNoteTile(
                                  note: state.notes[index],
                                  selections: state.selections);
                            },
                          ),
                        ),
                      ),
                  ],
                ),
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
          );
        },
      ),
    );
  }
}
