import 'package:flutter/material.dart';

class AudioNoteScreen extends StatelessWidget {
  const AudioNoteScreen({Key? key}) : super(key: key);

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
            TextButton(
              onPressed: () {},
              child: const Text('Record'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Pause'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Resume'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Stop'),
            ),
          ],
        ),
      ),
    );
  }
}
