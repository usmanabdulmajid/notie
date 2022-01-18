import 'package:flutter/cupertino.dart';

extension ContextExtension on BuildContext {
  double get barHeight => MediaQuery.of(this).viewPadding.top;
}
