import 'package:flutter/material.dart';
import 'package:notie/utils/app_color.dart';

class BorderTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  const BorderTextField({Key? key, this.controller, required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.only(left: 10.0),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
