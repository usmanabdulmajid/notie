import 'package:flutter/material.dart';
import 'package:notie/models/note.dart';
import 'package:notie/utils/app_color.dart';

class AudioNoteTile extends StatefulWidget {
  final Note note;
  const AudioNoteTile({required this.note, Key? key}) : super(key: key);

  @override
  State<AudioNoteTile> createState() => _AudioNoteTileState();
}

class _AudioNoteTileState extends State<AudioNoteTile> {
  bool _play = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {},
      child: Card(
        color: Color(widget.note.color),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: LayoutBuilder(builder: (context, constrain) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: constrain.maxWidth * .5,
                      child: Text(
                        widget.note.title!,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white),
                      ),
                    ),
                    const Icon(
                      Icons.upload,
                      size: 12.0,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _play = !_play;
                        });
                      },
                      child: PhysicalModel(
                        color: Color(widget.note.color),
                        elevation: 6.0,
                        shape: BoxShape.circle,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(widget.note.color),
                          ),
                          alignment: Alignment.center,
                          child: Icon(
                            _play ? Icons.pause : Icons.play_arrow,
                            color: AppColor.mainColor,
                          ),
                        ),
                      ),
                    ),
                    Text(widget.note.date)
                  ],
                )

                //Text(note.audioPath!),
              ],
            );
          }),
        ),
      ),
    );
  }
}
