import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/core/responsive/responsive_extention.dart';
import 'package:to_do_app/core/themes/app_colores.dart';
import 'package:to_do_app/core/utiles/widgets/custom_text.dart';

class CustomeDateWidget extends StatefulWidget {
  const CustomeDateWidget({super.key});

  @override
  State<CustomeDateWidget> createState() => DateWidgetState();
}

class DateWidgetState extends State<CustomeDateWidget> {
  String dateTitle = 'deadline_optional'.tr();

  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.white),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(data: dateTitle, color: AppColors.white),
            IconButton(
              onPressed: () async {
                final DateTime? date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  initialDate: DateTime.now(),
                  builder: (BuildContext context, Widget? child) {
                    return Theme(
                      data: ThemeData.light().copyWith(
                        colorScheme: ColorScheme.light(
                          primary: Colors.pink,
                          surface: AppColors.bink,
                          onPrimary: Colors.white,
                          onSurface: Colors.white,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                        ),
                        datePickerTheme: DatePickerThemeData(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          dayStyle: TextStyle(color: Colors.white),
                          todayBackgroundColor: WidgetStateProperty.all(
                            Colors.pink.shade100,
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                setState(() {
                  if (date != null) {
                    selectedDate = date;
                    dateTitle = DateFormat('dd MMMM yyyy').format(date);
                  }
                });
              },
              icon: Icon(Icons.calendar_today_outlined, color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
