
import 'package:flutter/widgets.dart';
import 'package:to_do_app/core/responsive/responsive_extention.dart';
import 'package:to_do_app/core/themes/app_colores.dart';
import 'package:to_do_app/core/utiles/widgets/custom_text.dart';
import 'package:to_do_app/core/utiles/widgets/tap_effect.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onClick;
  final String data;

  const CustomButton({super.key, required this.data, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("CustomButton tapped!"); // للتحقق
        onClick();
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 5.w,
        height: 6.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: CustomText(
            color: AppColors.bink,
            data: data,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
