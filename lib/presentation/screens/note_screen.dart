import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notie/application/cubit/notecubit_cubit.dart';
import 'package:notie/presentation/screens/compose_note_screen.dart';
import 'package:notie/utils/app_color.dart';

class NoteScreen extends StatefulWidget {
  NoteScreen({Key? key}) : super(key: key);

  @override
  State<NoteScreen> createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  List<String> xl = [
    'hejhejhjjjnjkll;;;;;nnnnnnnnnnnnnnnnnnnnn',
    'dcbnfvndvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvashvfhjevfhhjd ncvvvvvvvvnxxx heeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeev',
    'csdhhvc mhejjvegdcssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss'
  ];

  @override
  void initState() {
    super.initState();
    context.read<NotecubitCubit>().loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF01284E),
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
                    color: Colors.white,
                  ),
                ),
                const CircleAvatar(
                  backgroundColor: Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 40,
              padding: const EdgeInsets.only(left: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
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
            const SizedBox(height: 40),
            BlocBuilder<NotecubitCubit, NotecubitState>(
              builder: (context, state) {
                if (state is NoteLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                LoadNote note = state as LoadNote;
                return Expanded(
                  child: StaggeredGridView.countBuilder(
                    padding: EdgeInsets.zero,
                    crossAxisCount: 4,
                    itemCount: note.notes.length,
                    itemBuilder: (BuildContext context, int index) => Container(
                      width: MediaQuery.of(context).size.width * .45,
                      height: 300,
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Color(note.notes[index].color),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            note.notes[index].title!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              height: 2.0,
                            ),
                          ),
                          Text(
                            note.notes[index].body!,
                          ),
                          Align(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(Icons.upload),
                                Text(note.notes[index].date),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    staggeredTileBuilder: (int index) {
                      return StaggeredTile.count(2, index.isOdd ? 2 : 1.5);
                    },
                    mainAxisSpacing: 6.0,
                    crossAxisSpacing: 10.0,
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
            return const ComposeNoteScreen();
          }));
        },
        child: const Icon(Icons.create),
      ),
    );
  }
}
