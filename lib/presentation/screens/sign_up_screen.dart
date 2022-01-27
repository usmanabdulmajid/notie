import 'package:flutter/material.dart';
import 'package:notie/application/cubit/auth_cubit.dart';
import 'package:notie/presentation/widgets/alt_button.dart';
import 'package:notie/presentation/widgets/authentication_button.dart';
import 'package:notie/presentation/widgets/border_textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:notie/presentation/widgets/custom_status_bar.dart';
import 'package:notie/routes.dart';
import 'package:notie/utils/app_color.dart';
import 'package:notie/utils/validator.dart';
import 'package:provider/src/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with Validator {
  late TextEditingController _emailCtrl;
  late TextEditingController _passwordCtrl;
  final _formkey = GlobalKey<FormState>();

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
    final cubit = context.read<AuthCubit>();
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
              const SizedBox(height: 15),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: BorderTextField(
                        hintText: 'Email',
                        validator: validateEmail,
                        controller: _emailCtrl,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: BorderTextField(
                        hintText: 'Password',
                        validator: validatePassword,
                        controller: _passwordCtrl,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AuthenticationButton(
                onPressed: () async {
                  final validate = _formkey.currentState!.validate();
                  if (validate) {
                    final result = await cubit.signUpWithEmail(
                        _emailCtrl.text.trim(), _passwordCtrl.text.trim());

                    if (result) {
                      Navigator.pushNamed(context, Routes.home);
                    }
                  }
                },
                text: 'Sign up',
              ),
              Expanded(
                flex: 6,
                child: Row(
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
              ),
              Expanded(
                flex: 2,
                child: AltButton(
                  onPressed: () {},
                  iconData: FontAwesomeIcons.google,
                  text: 'Sign up with Google',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                flex: 2,
                child: AltButton(
                  onPressed: () {},
                  iconData: FontAwesomeIcons.facebook,
                  text: 'Sign up with Facebook',
                ),
              ),
              const SizedBox(height: 30.0),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.home);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.oranage.withOpacity(0.8),
                    ),
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
