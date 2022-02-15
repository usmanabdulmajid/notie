import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notie/common/utils/app_color.dart';

class CustomStatusBar extends StatelessWidget {
  final Widget child;
  const CustomStatusBar({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: AppColor.mainColor,
          statusBarIconBrightness: Brightness.light),
      child: child,
    );
  }
}
