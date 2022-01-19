import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
      child: Scaffold(
        backgroundColor: AppColor.mainColor,
        body: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          padding: const EdgeInsets.only(right: 15.0, left: 15.0, bottom: 20.0),
          child: Column(
            children: [
              SizedBox(height: context.barHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {},
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
              const SizedBox(height: 20),
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
                      AppSnackBar.success(context, 'Note Updated Successfully');
                    }
                  }
                },
                builder: (context, state) {
                  if (state is NoteLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SaveNote) {
                    return const SizedBox();
                  } else if (state is DeleteNote) {
                    return const SizedBox();
                  } else if (state is UpdateNote) {
                    return const SizedBox();
                  }

                  LoadNote note = state as LoadNote;
                  return Expanded(
                    child: MasonryGridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: note.notes.length,
                      mainAxisSpacing: 2.0,
                      crossAxisSpacing: 2.0,
                      gridDelegate:
                          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        if (note.notes[index].noteType == NoteType.audio) {
                          return AudioNoteTile(note: note.notes[index]);
                        }
                        return TextNoteTile(note: note.notes[index]);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator.pushNamed(context, Routes.composeNote);
          },
          child: const Icon(Icons.create),
        ),
      ),
    );
  }
}
