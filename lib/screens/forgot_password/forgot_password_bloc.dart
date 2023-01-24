import 'package:flutter/material.dart';
import 'package:mentor_app/shared_widget/account_service.dart';
import 'package:mentor_app/utils/mixins.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPasswordBloc extends Bloc<AccountService> {
  final TextEditingController emailFieldController = TextEditingController();
  ValueNotifier<bool> fieldsValidations = ValueNotifier<bool>(false);
  ValueNotifier<String> errorMessage = ValueNotifier<String>("");
  BuildContext? maincontext;
  ValueNotifier<bool> showHideEmailClearNotifier = ValueNotifier<bool>(false);

  handleListeners() {
    emailFieldController.addListener(_emailListen);
  }

  void _emailListen() {
    showHideEmailClearNotifier.value = emailFieldController.text.isNotEmpty;
  }

  fieldValidation() {
    fieldsValidations.value = false;
    if (emailFieldController.text.isNotEmpty) {
      if (_validateEmail(emailFieldController.text)) {
        errorMessage.value = "";
        fieldsValidations.value = true;
      } else {
        errorMessage.value = AppLocalizations.of(maincontext!)!.emailformatnotvalid;
      }
    }
  }

  bool _validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    return (!regex.hasMatch(value)) ? false : true;
  }

  @override
  onDispose() {}
}
