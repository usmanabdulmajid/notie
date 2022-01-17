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
import 'package:notie/utils/app_color.dart';
import 'package:notie/utils/enums.dart';

class NoteScreen extends StatefulWidget {
  const NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NotecubitCubit>().loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainColor,
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        padding: const EdgeInsets.only(right: 15.0, left: 15.0, bottom: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
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
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'search note',
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.mic),
                ),
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
              },
              builder: (context, state) {
                if (state is NoteLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SaveNote) {
                  return const SizedBox();
                } else if (state is DeleteNote) {
                  return const SizedBox();
                }

                LoadNote note = state as LoadNote;
                return Expanded(
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: note.notes.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      if (note.notes[index].noteType == NoteType.audio) {
                        return GestureDetector(
                          onTap: () async {
                            // Player player = Player(FlutterSound());
                            // await player.init();
                            // await player.play(note.notes[index].audioPath!);
                          },
                          child: Card(
                            color: Color(note.notes[index].color),
                            child: Column(
                              children: [
                                Text(note.notes[index].title!),
                                Text(note.notes[index].audioPath!)
                              ],
                            ),
                          ),
                        );
                      }
                      return Card(
                        color: Color(note.notes[index].color),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                note.notes[index].title!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                note.notes[index].body!,
                                maxLines: 6,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(height: 1.5),
                              ),
                              const Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Icons.upload,
                                    size: 12.0,
                                  ),
                                  Text(note.notes[index].date)
                                ],
                              )
                            ],
                          ),
                        ),
                      );
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
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const AudioNoteScreen();
          }));
        },
        child: const Icon(Icons.create),
      ),
    );
  }
}
