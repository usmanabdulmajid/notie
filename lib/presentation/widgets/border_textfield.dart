import 'package:flutter/material.dart';
import 'package:notie/utils/app_color.dart';

class BorderTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String hintText;

  const BorderTextField(
      {Key? key, this.controller, this.validator, required this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 40,
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
