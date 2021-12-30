import 'package:flutter/material.dart';
import 'package:notie/presentation/widgets/top_bar_buttom.dart';

class ComposeNoteScreen extends StatelessWidget {
  const ComposeNoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF01284E),
      body: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15.0, bottom: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TopBarButton(
                    onPressed: () {},
                    child: const ImageIcon(
                      AssetImage('asset/images/ios_arrow.png'),
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  TopBarButton(
                    onPressed: () {},
                    child: const Text(
                      'SAVE',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              const TextField(
                style: TextStyle(fontSize: 30, color: Colors.white),
                decoration: InputDecoration.collapsed(
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.white60, fontSize: 30)),
              ),
              const SizedBox(height: 50),
              const TextField(
                style: TextStyle(color: Colors.white),
                maxLines: null,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type something....',
                  hintStyle: TextStyle(color: Colors.white60),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
