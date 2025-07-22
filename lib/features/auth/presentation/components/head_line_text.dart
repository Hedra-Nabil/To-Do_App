import 'package:flutter/widgets.dart';
import 'package:to_do_app/core/themes/app_colores.dart';

class HeadLineText extends StatelessWidget {
  const HeadLineText({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        color: AppColors.bink,
        fontWeight: FontWeight.w900,
        fontSize: 35,
      ),
    );
  }
}
