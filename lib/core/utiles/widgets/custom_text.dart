import 'package:flutter/material.dart';
import 'package:to_do_app/core/themes/app_colores.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {super.key, required this.data, this.fontSize, this.fontWeight, this.color});

  final String data;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.w400,
        fontStyle: FontStyle.normal,
        fontSize: fontSize ?? 14.0,
        height: 1.7,
        letterSpacing: 0.0,
        color: color??AppColors.grey,
      ),
    );
  }
}
