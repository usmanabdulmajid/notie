import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignedIn) {
          Navigator.pushReplacementNamed(context, Routes.home);
        }
      },
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20.0),
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
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: BorderTextField(
                          hintText: 'Email',
                          validator: validateEmail,
                          controller: _emailCtrl,
                          errorText:
                              state is EmailAlreadyInUse ? state.message : null,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: BorderTextField(
                          hintText: 'Password',
                          validator: validatePassword,
                          controller: _passwordCtrl,
                          errorText:
                              state is PasswordIsWeak ? state.message : null,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            AuthenticationButton(
              onPressed: () async {
                final validate = _formkey.currentState!.validate();
                if (validate) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  await cubit.signUpWithEmail(
                      _emailCtrl.text.trim(), _passwordCtrl.text.trim());
                }
              },
              text: 'Sign up',
            ),
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            AltButton(
              onPressed: () {},
              iconData: FontAwesomeIcons.google,
              text: 'Sign up with Google',
            ),
            const SizedBox(
              height: 15,
            ),
            AltButton(
              onPressed: () {},
              iconData: FontAwesomeIcons.facebook,
              text: 'Sign up with Facebook',
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
                onPressed: () {
                  Navigator.pushNamed(context, Routes.signIn);
                },
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
    );
  }
}
