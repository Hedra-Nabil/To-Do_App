import 'package:flutter/cupertino.dart';

class ResponsiveCalculation {
  static final MediaQueryData _mediaQueryData = MediaQueryData.fromView(
      WidgetsBinding.instance.platformDispatcher.views.first);

  static double calculateHeight(double h) =>(_mediaQueryData.size.height /100)*h;
  static double calculateWidth(double w) =>(_mediaQueryData.size.width /100)*w;
}