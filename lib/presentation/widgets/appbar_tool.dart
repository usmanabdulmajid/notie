import 'package:flutter/material.dart';

class AppBarTool extends StatelessWidget with PreferredSizeWidget {
  Widget child;
  AppBarTool({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: child);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
