import 'package:flutter/material.dart';
import 'package:notie/presentation/widgets/border_textfield.dart';
import 'package:notie/presentation/widgets/authentication_button.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF01284E),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        padding: const EdgeInsets.only(right: 15.0, left: 15, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            const Text(
              'Create account',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 50),
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 70,
                  ),
                  Positioned(
                    bottom: 12,
                    right: -12,
                    child: IconButton(
                      color: const Color(0XFF01284E),
                      onPressed: () {},
                      icon: const Icon(Icons.photo_camera),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 30),
            const BorderTextField(hintText: 'username'),
            const SizedBox(height: 30),
            const BorderTextField(hintText: 'email'),
            const SizedBox(height: 30),
            const BorderTextField(hintText: 'password'),
            const SizedBox(height: 60),
            AuthenticationButton(
              onPressed: () {},
              text: 'create account',
            ),
          ],
        ),
      ),
    );
  }
}
