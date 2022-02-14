import 'package:flutter/material.dart';
import 'package:notie/models/note.dart';
import 'package:notie/presentation/widgets/top_bar_buttom.dart';
import 'package:notie/routes.dart';
import 'package:notie/utils/app_color.dart';
import 'package:notie/utils/extensions.dart';

class ReadNoteScreen extends StatelessWidget {
  final Note note;
  const ReadNoteScreen({
    required this.note,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15.0, bottom: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.barHeight),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TopBarButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const ImageIcon(
                      AssetImage('asset/images/ios_arrow.png'),
                      color: AppColor.white,
                      size: 16,
                    ),
                  ),
                  TopBarButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.composeNote,
                          arguments: note);
                    },
                    child: const ImageIcon(
                      AssetImage('asset/images/edit.png'),
                      color: AppColor.white,
                      size: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                note.title!,
                maxLines: null,
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.white60,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                note.date,
                style: const TextStyle(color: Colors.white30, fontSize: 18),
              ),
              const SizedBox(height: 20),
              Text(
                note.body!,
                maxLines: null,
                style: const TextStyle(color: AppColor.white, fontSize: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
