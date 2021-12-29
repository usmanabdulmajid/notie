import 'package:flutter/material.dart';
import 'package:notie/presentation/widgets/alt_button.dart';
import 'package:notie/presentation/widgets/authentication_button.dart';
import 'package:notie/presentation/widgets/border_textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0XFF01284E),
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.only(right: 15.0, left: 15, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            const Text(
              'Sign up',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 50),
            const BorderTextField(hintText: 'email'),
            const SizedBox(height: 30),
            const BorderTextField(hintText: 'password'),
            const SizedBox(height: 40),
            AuthenticationButton(
              onPressed: () {},
              text: 'sign up',
            ),
            const SizedBox(height: 30),
            Row(
              children: const [
                Expanded(
                    child: Divider(
                  color: Colors.white,
                  thickness: 2.0,
                )),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'OR',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                    child: Divider(
                  color: Colors.white,
                  thickness: 2.0,
                )),
              ],
            ),
            const SizedBox(height: 30),
            AltButton(
              onPressed: () {},
              iconData: FontAwesomeIcons.google,
              text: 'sign up with google',
            ),
            const SizedBox(height: 30),
            AltButton(
              onPressed: () {},
              iconData: FontAwesomeIcons.facebook,
              text: 'sign up with facebook',
            ),
            const SizedBox(height: 30.0),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0XFFFF6F06).withOpacity(0.8),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Skip',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Already have an account? Sign In',
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
