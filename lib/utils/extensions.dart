import 'package:flutter/cupertino.dart';

extension ContextExtension on BuildContext {
  double get barHeight => MediaQuery.of(this).viewPadding.top;
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  bool get openKeyboard => MediaQuery.of(this).viewInsets.bottom == 0;
}
