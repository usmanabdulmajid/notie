import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notie/application/cubit/auth_cubit.dart';
import 'package:notie/presentation/widgets/custom_status_bar.dart';
import 'package:notie/routes.dart';
import 'package:notie/utils/app_color.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          //context.read<AuthCubit>().loadDetails();
        } else if (state is SignedIn) {
          Navigator.pushReplacementNamed(context, Routes.home);
        } else if (state is SignIn) {
          Navigator.pushReplacementNamed(context, Routes.signUp);
        }
      },
      builder: (context, state) {
        context.read<AuthCubit>().authState();
        if (state is AuthLoading) {
          context.read<AuthCubit>().loadDetails();
        }
        return Scaffold(
          body: Center(
            child: Image.asset('asset/images/notie.png'),
          ),
        );
      },
    );
  }
}
