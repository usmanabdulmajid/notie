import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notie/presentation/widgets/alt_button.dart';
import 'package:notie/presentation/widgets/authentication_button.dart';
import 'package:notie/presentation/widgets/border_textfield.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

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
              'Sign in',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 50),
            const BorderTextField(hintText: 'email or username'),
            const SizedBox(height: 30),
            const BorderTextField(hintText: 'password'),
            const SizedBox(height: 40),
            AuthenticationButton(
              onPressed: () {},
              text: 'sign in',
            ),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
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
              text: 'continue with google',
            ),
            const SizedBox(height: 30),
            AltButton(
              onPressed: () {},
              iconData: FontAwesomeIcons.facebook,
              text: 'continue with facebook',
            ),
            const Spacer(),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Don\'t have an account? Sign Up',
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
