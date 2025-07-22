import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do_app/core/constants/icons_constants.dart';
import 'package:to_do_app/core/responsive/responsive_extention.dart';
import 'package:to_do_app/core/themes/app_colores.dart';
import 'package:to_do_app/core/constants/font_constants.dart';
import 'package:to_do_app/core/constants/padding_constants.dart';
import 'package:to_do_app/core/constants/size_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/themes/theme_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showChangeEmailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('change_email'.tr()),
            content: TextField(
              decoration: InputDecoration(hintText: 'enter_new_email'.tr()),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('cancel'.tr()),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Implement email change logic
                  Navigator.pop(context);
                },
                child: Text('save'.tr()),
              ),
            ],
          ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('change_password'.tr()),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'current_password'.tr(),
                  ),
                ),
                SizedBox(height: SizeConstants.height10),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(hintText: 'new_password'.tr()),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('cancel'.tr()),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Implement password change logic
                  Navigator.pop(context);
                },
                child: Text('save'.tr()),
              ),
            ],
          ),
    );
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('logout'.tr()),
            content: Text('confirm_logout'.tr()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('cancel'.tr()),
              ),
              TextButton(
                onPressed: () {
                  // TODO: Implement logout logic
                  Navigator.pop(context);
                },
                child: Text('logout'.tr()),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: PaddingConstants.horizontalPadding6.w,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<ThemeCubit, ThemeMode>(
                  builder: (context, themeMode) {
                    return ColorFiltered(
                      colorFilter: themeMode == ThemeMode.dark
                          ? ColorFilter.mode(
                              AppColors.darkText,
                              BlendMode.modulate,
                            )
                          : ColorFilter.mode(
                              Colors.transparent,
                              BlendMode.multiply,
                            ),
                      child: SvgPicture.asset(IconsConstants.rafiki),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: SizeConstants.height7.h),
            ProfileItemRow(
              hint: 'name'.tr(),
              icon: Icons.arrow_back_ios_new_rounded,
            ),
            SizedBox(height: SizeConstants.height3.h),
            GestureDetector(
              onTap: () => _showChangeEmailDialog(context),
              child: ProfileItemRow(
                hint: 'change_email'.tr(),
                icon: Icons.arrow_back_ios_new_rounded,
              ),
            ),
            SizedBox(height: SizeConstants.height3.h),
            GestureDetector(
              onTap: () => _showChangePasswordDialog(context),
              child: ProfileItemRow(
                hint: 'change_password'.tr(),
                icon: Icons.arrow_back_ios_new_rounded,
              ),
            ),
            SizedBox(height: 3.h),
            LanguageToggleRow(),
            SizedBox(height: SizeConstants.height7.h),
            GestureDetector(
              onTap: () => _logout(context),
              child: Row(
                children: [
                  Text(
                    'logout'.tr(),
                    style: TextStyle(
                      color: AppColors.bink,
                      fontSize: FontConstants.font20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileItemRow extends StatelessWidget {
  const ProfileItemRow({super.key, required this.hint, required this.icon, this.onTap});

  final String hint;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Row(
          children: [
            if (context.locale.languageCode == 'ar') ...[
              Icon(icon, color: AppColors.bink, size: 24),
              SizedBox(width: 12.w),
            ],

            Expanded(
              child: Text(
                hint,
                style: TextStyle(
                  fontSize: FontConstants.font18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            if (context.locale.languageCode == 'en') ...[
              SizedBox(width: 12.w),
              Icon(icon, color: AppColors.bink, size: 24),
            ],

            if (onTap != null)
              Icon(
                context.locale.languageCode == 'ar'
                    ? Icons.arrow_forward_ios_rounded
                    : Icons.arrow_back_ios_new_rounded,
                color: Colors.grey,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }
}

class LanguageToggleRow extends StatelessWidget {
  const LanguageToggleRow({super.key});

  @override
  Widget build(BuildContext context) {
    bool isArabic = context.locale.languageCode == 'ar';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('change_language'.tr()),
        Switch(
          value: isArabic,
          onChanged: (value) {
            if (value) {
              context.setLocale(Locale('ar'));
            } else {
              context.setLocale(Locale('en'));
            }
          },
          activeColor: AppColors.bink,
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: Colors.grey.withOpacity(0.3),
        ),
      ],
    );
  }
}
