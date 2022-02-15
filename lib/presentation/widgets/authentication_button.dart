import 'package:flutter/material.dart';
import 'package:notie/common/utils/app_color.dart';

class AuthenticationButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const AuthenticationButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.maxFinite,
        height: 50,
        decoration: BoxDecoration(
          color: AppColor.oranage,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: const TextStyle(
            color: AppColor.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
