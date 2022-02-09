import 'package:flutter/material.dart';
import 'package:notie/utils/app_color.dart';

class AltButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;
  final String text;
  const AltButton(
      {Key? key,
      required this.onPressed,
      required this.iconData,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.maxFinite,
        //height: 45,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, color: AppColor.mainColor),
            const SizedBox(width: 10),
            Text(
              text,
              style: const TextStyle(
                color: AppColor.mainColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
