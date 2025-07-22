import 'package:easy_localization/easy_localization.dart';

class AppValidator {
  static String? validateName(String value) {
    final nameRegExp = RegExp(r"^[A-Z][a-zA-Z]{2,}(?: [A-Z][a-zA-Z]{2,})*$");
    if (value.isEmpty || !nameRegExp.hasMatch(value)) {
      return 'name_invalid'.tr();
    }
    return null;
  }

  static String? emailName(String? value) {
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (value == null || value.isEmpty || !emailRegExp.hasMatch(value)) {
      return 'email_invalid'.tr();
    }
    return null;
  }

  static String? passwordValidation(String? value) {
    final passwordRegExp = RegExp(r'^(?=(?:.*\d){8,})[a-zA-Z\d]{8,}$');
    if (value == null || value.isEmpty || !passwordRegExp.hasMatch(value)) {
      return 'password_invalid'.tr();
    }
    return null;
  }

  static String? passwordConfirmValidation(String? password, String confirm) {
    if (password != confirm) {
      return 'passwords_not_match'.tr();
    }
    return null;
  }
}
