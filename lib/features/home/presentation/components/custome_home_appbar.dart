import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_app/core/responsive/responsive_extention.dart';
import 'package:to_do_app/features/profile/presentation/ui_screens/profile_screen.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 7.h,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            'assets/Icons/mobile_tech.svg',
            width: 8.w,
            height: 8.h,
          ),
          GestureDetector(
            child: SvgPicture.asset(
              'assets/Icons/Profile.svg',
              width: 5.w,
              height: 5.h,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
