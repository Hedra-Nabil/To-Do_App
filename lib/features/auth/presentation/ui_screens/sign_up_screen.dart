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
import 'package:to_do_app/features/auth/presentation/controllers/sign_up_cubit/sign_up_cubit.dart';

class SignUpScreen extends StatelessWidget {
   SignUpScreen({super.key});

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Logo(),
                SizedBox(
                  height: 2.h,
                ),
                CustomTextFormField(
                  maxlienx: 1,
                  colorx: AppColors.grey,
                    validators: (value) =>
                        AppValidator.validateName(value ?? ''),
                    controller: fullNameController,
                    hint: 'full_name'.tr()),
                    
                SizedBox(
                  height: 1.h,
                ),
                CustomTextFormField(
                  maxlienx: 1,
                  colorx: AppColors.grey,
                    validators: (value) => AppValidator.emailName(value),
                    controller: emailController,
                    hint: 'email'.tr()),
                SizedBox(
                  height: 1.h,
                ),
                CustomTextFormField(
                  maxlienx: 1,
                  colorx: AppColors.grey,
                  validators: (value) => AppValidator.passwordValidation(value),
                  controller: passwordController,
                  hint: 'password'.tr(),
                  isPassword: true,
                ),
                SizedBox(
                  height: 1.h,
                ),
                CustomTextFormField(
                  maxlienx: 1,
                  colorx: AppColors.grey,
                  validators: (value) => AppValidator.passwordConfirmValidation(
                      value, passwordController.text),
                  controller: confirmPasswordController,
                  hint: 'confirm_password'.tr(),
                  isPassword: true,
                ),
                SizedBox(
                  height: 2.h,
                ),
                BlocConsumer<SignUpCubit, SignUpState>(
                  listener: (context, state) {
                    // TODO: implement listener
                    if(state is SignUpFailure)
                      {
                        showDialog(context: context, builder: (context) => AlertDialog(
                          title: Text('Error',),
                          content: Text(state.message),
                        ),);
                      }
                  },
                  builder: (context, state) {
                    return CustomAuthButton(
                      data: 'sign_up',
                      onTap: () {
                        //jkn
                        // if (formKey.currentState!.validate()) {
                          print('object');
                          context.read<SignUpCubit>().signUpWithFirebase(
                              emailController.text, passwordController.text);
                        // }
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      style: ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                      child: CustomText(data: 'have_an_account'.tr()),
                      onPressed: () {},
                    ),
                    TextButton(
                      style: ButtonStyle(
                          padding: WidgetStatePropertyAll(EdgeInsets.zero)),
                      child: CustomText(
                        data: 'login'.tr(),
                        color: AppColors.bink,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ));
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
