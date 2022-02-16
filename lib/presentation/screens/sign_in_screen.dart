import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:notie/cubit/auth_cubit.dart';
import 'package:notie/presentation/widgets/alt_button.dart';
import 'package:notie/presentation/widgets/authentication_button.dart';
import 'package:notie/presentation/widgets/border_textfield.dart';
import 'package:notie/routes.dart';
import 'package:notie/common/utils/app_color.dart';
import 'package:notie/common/utils/validator.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with Validator {
  late TextEditingController _emailCtrl;
  late TextEditingController _passwordCtrl;
  late final _formKey = GlobalKey<FormState>();

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
      child: LoaderOverlay(
        useDefaultLoading: false,
        child: Scaffold(
          body: ListView(
            padding:
                const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
            children: [
              const SizedBox(height: 100),
              const Text(
                'Sign in',
                style: TextStyle(
                  color: AppColor.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 50),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        BorderTextField(
                          hintText: 'Email',
                          validator: validateEmail,
                          controller: _emailCtrl,
                          errorText:
                              state is InvalidUser ? state.message : null,
                        ),
                        const SizedBox(height: 30),
                        BorderTextField(
                          hintText: 'Password',
                          validator: validatePassword,
                          controller: _passwordCtrl,
                          errorText:
                              state is InvalidPassword ? state.message : null,
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              AuthenticationButton(
                onPressed: () async {
                  final validate = _formKey.currentState!.validate();
                  if (validate) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    context.loaderOverlay.show(
                      widget: const Center(
                        child: SpinKitFadingCircle(
                          color: AppColor.oranage,
                        ),
                      ),
                    );
                    await cubit.loginWithEmail(
                        _emailCtrl.text, _passwordCtrl.text);
                    context.loaderOverlay.hide();
                  }
                },
                text: 'Sign in',
              ),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(color: AppColor.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
                onPressed: () async {
                  context.loaderOverlay.show(
                      widget: const Center(
                    child: SpinKitFadingCircle(
                      color: AppColor.oranage,
                    ),
                  ));
                  await cubit.googleSignIn();
                  context.loaderOverlay.hide();
                },
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
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.signUp);
                  },
                  child: const Text(
                    'Don\'t have an account? Sign Up',
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
