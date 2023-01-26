import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mentor_app/models/https/forgot_password_request.dart';
import 'package:mentor_app/services/auth_services.dart';
import 'package:mentor_app/utils/enums/loading_status.dart';
import 'package:mentor_app/utils/mixins.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mentor_app/utils/routes.dart';

class ForgotPasswordBloc extends Bloc<AuthService> {
  final TextEditingController emailFieldController = TextEditingController();
  ValueNotifier<bool> fieldsValidations = ValueNotifier<bool>(false);
  ValueNotifier<String> errorMessage = ValueNotifier<String>("");
  BuildContext? maincontext;
  ValueNotifier<bool> showHideEmailClearNotifier = ValueNotifier<bool>(false);
  ValueNotifier<LoadingStatus> loadingStatusNotifier = ValueNotifier<LoadingStatus>(LoadingStatus.idle);

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

  void doForgotPasswordCall() async {
    loadingStatusNotifier.value = LoadingStatus.inprogress;
    final ForgotPasswordRequest data = ForgotPasswordRequest(email: emailFieldController.text);

    try {
      await service.forgotPassword(data: data);
      loadingStatusNotifier.value = LoadingStatus.finish;
      _openConfirmScreen(maincontext!);
    } on DioError {
      errorMessage.value = AppLocalizations.of(maincontext!)!.wrongemail;
      loadingStatusNotifier.value = LoadingStatus.finish;
    }
  }

  void _openConfirmScreen(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pushNamed(
      RoutesConstants.forgotPasswordConfirmationScreen,
      arguments: {
        "email": emailFieldController.text,
      },
    );
  }

  @override
  onDispose() {}
}
