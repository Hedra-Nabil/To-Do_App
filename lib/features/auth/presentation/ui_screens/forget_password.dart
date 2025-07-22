import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/responsive/responsive_extention.dart';
import 'package:to_do_app/core/themes/app_colores.dart';
import 'package:to_do_app/core/utiles/widgets/custom_field.dart';
import 'package:to_do_app/core/utiles/widgets/custom_text.dart';
import 'package:to_do_app/core/validator/app_validator.dart';
import 'package:to_do_app/features/auth/presentation/components/custom_auth_button.dart';
import 'package:to_do_app/features/auth/presentation/components/logo.dart';
import 'package:to_do_app/features/auth/presentation/controllers/login_cubit/login_cubit.dart';
import 'package:to_do_app/features/auth/presentation/ui_screens/sign_up_screen.dart';
import 'package:to_do_app/features/home/presentation/ui_screens/home_screen.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Logo(),
                CustomTextFormField(
                  maxlienx: 1,
                  validators: (p0) => AppValidator.emailName(p0),
                  controller: emailController,
                  hint: 'email',
                  colorx: AppColors.grey,
                ),
                SizedBox(height: 3.h),
                CustomTextFormField(
                  maxlienx: 1,
                  validators: (p0) => AppValidator.emailName(p0),
                  controller: emailController,
                  hint: 'Password',
                  colorx: AppColors.grey,
                  isPassword: true,
                ),
                SizedBox(height: 3.h),
                CustomTextFormField(
                  maxlienx: 1,
                  validators: (p0) => AppValidator.passwordValidation(p0),
                  controller: passwordController,
                  hint: 'Confirm Password',
                  colorx: AppColors.grey,
                  isPassword: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: CustomText(data: 'forget_password'.tr()),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginFailure) {
                      showDialog(
                        context: context,
                        builder:
                            (context) => AlertDialog(
                              title: Text('Error'),
                              content: Text(state.message),
                            ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomAuthButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          context.read<LoginCubit>().signInWIthFirebase(
                            emailController.text,
                            passwordController.text,
                          );
                        }
                        if (state is LoginSuccess) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        }
                      },
                      data: 'CHANGE PASSWORD'.tr(),
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                        padding: WidgetStatePropertyAll(EdgeInsets.zero),
                      ),
                      child: CustomText(data: 'dont_have_an_account'.tr()),
                      onPressed: () {},
                    ),
                    TextButton(
                      style: ButtonStyle(
                        padding: WidgetStatePropertyAll(EdgeInsets.zero),
                      ),
                      child: CustomText(
                        data: 'sign_up'.tr(),
                        color: AppColors.bink,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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
