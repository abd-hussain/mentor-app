import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/models/password_strength_model.dart';
import 'package:mentor_app/password_strenght_logic.dart';
import 'package:mentor_app/shared_widget/account_service.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/mixins.dart';

class ChangePasswordBloc extends Bloc<AccountService> {
  bool currentPassowrdObscureText = true;
  bool newPasswordObscureText = true;
  bool confirmPasswordObscureText = true;
  bool enableSaveButton = false;
  bool enableNewPasswordTextField = false;
  bool enableConfirmPasswordTextField = false;

  final TextEditingController currentPasswordFieldController = TextEditingController();
  final TextEditingController newPasswordFieldController = TextEditingController();
  final TextEditingController confirmPasswordFieldController = TextEditingController();

  final ValueNotifier<PasswordStrengthModel> passwordStrengthValidationNotifier =
      ValueNotifier<PasswordStrengthModel>(PasswordStrengthModel());

  final ValueNotifier<String> infoNotifier = ValueNotifier<String>("* You Have to fill Current Password first");
  final box = Hive.box(DatabaseBoxConstant.userInfo);

  bool validateCurrentPassword(String text) {
    if (box.get(DatabaseFieldConstant.biometricP) == text) {
      infoNotifier.value = "* Now You can fill your new password";
      enableNewPasswordTextField = true;
      return true;
    }
    infoNotifier.value = "* Your Current Password is Wrong";
    return false;
  }

  clearFields() {
    currentPasswordFieldController.clear();
    newPasswordFieldController.clear();
    confirmPasswordFieldController.clear();
    enableNewPasswordTextField = false;
    enableConfirmPasswordTextField = false;
    passwordStrengthValidationNotifier.value = PasswordStrengthModel();
  }

  bool checkerOfThePasswordStrength() {
    return PasswordsStrength()
        .checkerOfThePasswordStrength(passwordStrengthValidationNotifier: passwordStrengthValidationNotifier);
  }

  @override
  onDispose() {
    clearFields();
    currentPasswordFieldController.dispose();
    newPasswordFieldController.dispose();
    confirmPasswordFieldController.dispose();
    passwordStrengthValidationNotifier.dispose();
  }
}
