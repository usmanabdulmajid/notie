import 'dart:math';

import 'package:flutter/cupertino.dart';

mixin HelperMixin {
  bool nonEmptyNote(String title, String body) {
    return title.isNotEmpty && body.isNotEmpty;
  }

  Color noteColor() {
    List<Color> colors = const [
      Color(0XFFE05D5D),
      Color(0XFFFFF8E5),
      Color(0XFFFFB344),
      Color(0XFF00A19D),
      Color(0XFFFF6F06)
    ];
    int random = Random().nextInt(colors.length);
    return colors[random];
  }
}
