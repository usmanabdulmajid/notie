import 'package:flutter/material.dart';
import 'package:notie/application/cubit/auth_cubit.dart';
import 'package:notie/presentation/widgets/alt_button.dart';
import 'package:notie/presentation/widgets/authentication_button.dart';
import 'package:notie/presentation/widgets/border_textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notie/presentation/widgets/custom_status_bar.dart';
import 'package:notie/routes.dart';
import 'package:notie/utils/app_color.dart';
import 'package:provider/src/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController _emailCtrl;
  late TextEditingController _passwordCtrl;

  @override
  void initState() {
    super.initState();
    _emailCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomStatusBar(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColor.mainColor,
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
                  color: AppColor.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 50),
              BorderTextField(
                hintText: 'email',
                controller: _emailCtrl,
              ),
              const SizedBox(height: 30),
              BorderTextField(
                hintText: 'password',
                controller: _passwordCtrl,
              ),
              const SizedBox(height: 40),
              AuthenticationButton(
                onPressed: () async {
                  await context
                      .read<AuthCubit>()
                      .signUpWithEmail(_emailCtrl.text, _passwordCtrl.text);
                },
                text: 'sign up',
              ),
              const SizedBox(height: 30),
              Row(
                children: const [
                  Expanded(
                      child: Divider(
                    color: AppColor.white,
                    thickness: 2.0,
                  )),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'OR',
                      style: TextStyle(color: AppColor.white),
                    ),
                  ),
                  Expanded(
                      child: Divider(
                    color: AppColor.white,
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
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.home);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.oranage.withOpacity(0.8),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Skip',
                      style: TextStyle(color: AppColor.white),
                    ),
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
                      color: AppColor.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
