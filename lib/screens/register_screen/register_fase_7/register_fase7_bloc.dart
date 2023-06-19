import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';

class Register7Bloc {
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  ValueNotifier<bool> enableNextBtn = ValueNotifier<bool>(false);

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  ValueNotifier<bool> showHidePasswordClearNotifier = ValueNotifier<bool>(false);
  ValueNotifier<bool> showHideConfirmPasswordClearNotifier = ValueNotifier<bool>(false);

  ValueNotifier<bool> passwordEquilConfirmPasswordNotifier = ValueNotifier<bool>(false);
  ValueNotifier<bool> passwordMoreThan8CharNotifier = ValueNotifier<bool>(false);
  ValueNotifier<bool> passwordHaveNumberNotifier = ValueNotifier<bool>(false);

  handleListeners() {
    passwordController.addListener(_passwordListen);
    confirmPasswordController.addListener(_confirmPasswordListen);
  }

  void _passwordListen() {
    showHidePasswordClearNotifier.value = passwordController.text.isNotEmpty;
    validateFieldsForFaze7();
  }

  void _confirmPasswordListen() {
    showHideConfirmPasswordClearNotifier.value = confirmPasswordController.text.isNotEmpty;
    validateFieldsForFaze7();
  }

  validateFieldsForFaze7() {
    if (passwordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty) {
      passwordEquilConfirmPasswordNotifier.value = (passwordController.text == confirmPasswordController.text);
      passwordMoreThan8CharNotifier.value =
          (passwordController.text.length >= 8 || confirmPasswordController.text.length >= 8);
      passwordHaveNumberNotifier.value = (passwordController.text.contains(RegExp(r'[0-9]')) ||
          confirmPasswordController.text.contains(RegExp(r'[0-9]')));

      enableNextBtn.value = passwordEquilConfirmPasswordNotifier.value &&
          passwordMoreThan8CharNotifier.value &&
          passwordHaveNumberNotifier.value;
    }
  }
}
