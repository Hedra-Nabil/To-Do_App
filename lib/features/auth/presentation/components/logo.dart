import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_app/core/responsive/responsive_extention.dart';
import 'package:to_do_app/features/auth/presentation/ui_screens/forget_password.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    HeadLineText(
                      data: 'T',
                    ),
                    SizedBox(
                      width: 7.w,
                    ),
                    HeadLineText(
                      data: 'O',
                    )
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    HeadLineText(
                      data: 'D',
                    ),
                    SizedBox(
                      width: 7.w,
                    ),
                    HeadLineText(
                      data: 'O',
                    )
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    HeadLineText(
                      data: 'L',
                    ),
                    SizedBox(
                      width: 7.w,
                    ),
                    HeadLineText(
                      data: 'I',
                    )
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 5.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/Icons/mobile_tech.svg'),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    HeadLineText(
                      data: 'S',
                    ),
                    SizedBox(
                      width: 7.w,
                    ),
                    HeadLineText(
                      data: 'T',
                    )
                  ],
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 7.h,
        ),
      ],
    );
  }
}
