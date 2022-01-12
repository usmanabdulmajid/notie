import 'package:flutter/material.dart';
import 'package:notie/presentation/widgets/top_bar_buttom.dart';
import 'package:notie/utils/app_color.dart';

class ReadNoteScreen extends StatelessWidget {
  const ReadNoteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainColor,
      body: Padding(
        padding: const EdgeInsets.only(right: 15.0, left: 15.0, bottom: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TopBarButton(
                    onPressed: () {},
                    child: const ImageIcon(
                      AssetImage('asset/images/ios_arrow.png'),
                      color: AppColor.white,
                      size: 16,
                    ),
                  ),
                  TopBarButton(
                    onPressed: () {},
                    child: const ImageIcon(
                      AssetImage('asset/images/edit.png'),
                      color: AppColor.white,
                      size: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'Beautiful weather app u concepts we wish existed',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white60,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Dec 30, 2021',
                style: TextStyle(color: Colors.white30),
              ),
              const SizedBox(height: 20),
              const Text(
                '''The Bankai (卍解, Final Release) is the second and final upgraded form of a Zanpakutō. To achieve Bankai, one must be able to materialize and subjugate their Zanpakutō spirit. Materialization means the opposite of getting dragged into the Zanpakutō's inner world. Instead the wielder needs to summon the Zanpakutō's spirit into the physical world. It usually takes 10 years or more to achieve, plus the experience needed to master it.

The power and forms of Shikai and Bankai are dependent on the Zanpakutō. They also vary according to the wielder's strength and training. But in general, one's power can grow 5 to 10 times greater. Only the strongest Shinigami can use it. It is also the ultimate technique of a Zanpakutō. Even the Four noble families, whose members are always exceptionally talented, have a member capable of Bankai only every few generations. Those who achieve Bankai always have remarkable roles in the history of Soul Society.''',
                maxLines: null,
                style: TextStyle(color: AppColor.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
