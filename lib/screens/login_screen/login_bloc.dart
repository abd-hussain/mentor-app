import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/locator.dart';
import 'package:mentor_app/models/authentication_models.dart';
import 'package:mentor_app/services/auth_services.dart';
import 'package:mentor_app/services/general/authentication_service.dart';
import 'package:mentor_app/services/general/network_info_service.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/error/exceptions.dart';
import 'package:mentor_app/utils/mixins.dart';
import 'package:mentor_app/utils/routes.dart';

class LoginBloc extends Bloc<AuthService> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  ValueNotifier<bool> showHideEmailClearNotifier = ValueNotifier<bool>(false);
  ValueNotifier<bool> showHidePasswordClearNotifier = ValueNotifier<bool>(false);
  ValueNotifier<bool> showHidePasswordNotifier = ValueNotifier<bool>(false);
  ValueNotifier<String> errorPasswordMessageNotifier = ValueNotifier<String>("");
  ValueNotifier<bool> buildNotifier = ValueNotifier<bool>(false);

  ValueNotifier<AuthenticationBiometricType> biometricResultNotifier =
      ValueNotifier<AuthenticationBiometricType>(AuthenticationBiometricType(isAvailable: false, type: null));
  final box = Hive.box(DatabaseBoxConstant.userInfo);
  bool isBiometricAppeared = false;
  bool biometricStatus = false;
  final authenticationService = locator<AuthenticationService>();

  handleListeners() {
    emailController.addListener(_emailListen);
    passwordController.addListener(_passwordListen);
  }

  void _emailListen() {
    showHideEmailClearNotifier.value = (emailFocus.hasFocus && emailController.text.isNotEmpty);
  }

  void _passwordListen() {
    showHidePasswordClearNotifier.value = (passwordFocus.hasFocus && passwordController.text.isNotEmpty);
  }

  void showHidePassword() {
    errorPasswordMessageNotifier.value = '';
    showHidePasswordNotifier.value = !showHidePasswordNotifier.value;
  }

  Future<void> initBiometric(BuildContext context) async {
    if (!(await locator<NetworkInfoService>().isConnected())) {
      await _readBiometricData(context);
    }
  }

  Future<void> _readBiometricData(BuildContext context) async {
    final String biometricU = box.get(DatabaseFieldConstant.biometricU);
    final String biometricP = box.get(DatabaseFieldConstant.biometricP);

    isBiometricAppeared = true;
    biometricStatus =
        box.get(DatabaseFieldConstant.biometricStatus) == 'true' && biometricP.isNotEmpty && biometricU.isNotEmpty;

    if (await _checkAuthentication(Theme.of(context).platform)) {
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        Future.delayed(
          const Duration(seconds: 1),
          () async {
            if (biometricStatus) {
              await tryToAuthintecateUserByBiometric(context);
            }
          },
        );
      });
    } else {
      isBiometricAppeared = false;
    }
  }

  Future tryToAuthintecateUserByBiometric(BuildContext context) async {
    if (await authenticationService.isBiometricAvailable()) {
      if (await authenticationService.shouldAllowBiometricAuthenticationToContinue(Theme.of(context).platform)) {
        // continue with authentication
        isBiometricAppeared = true;
        final authentication = await authenticationService.authenticateUser("Please use your biometric signature");
        if (authentication.success) {
          final String biometricU = box.get(DatabaseFieldConstant.biometricU);
          final String biometricP = box.get(DatabaseFieldConstant.biometricP);

          if (!(await locator<NetworkInfoService>().isConnected())) {
            throw ConnectionException(message: "Please check your internet connection");
          } else {
            doLoginCall(context: context, userName: biometricU, password: biometricP, isBiometricLogin: true);
            isBiometricAppeared = false;
          }
        } else {
          isBiometricAppeared = false;
        }
      }
    } else {
      isBiometricAppeared = false;
    }
  }

  Future<bool> _checkAuthentication(TargetPlatform platform) async {
    if (await authenticationService.isBiometricAvailable()) {
      biometricResultNotifier.value = await (authenticationService.getAvailableBiometricTypes(platform));
      buildNotifier.value = true;
      return true;
    }
    return false;
  }

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern as String);
    return (!regex.hasMatch(value)) ? false : true;
  }

  void _openMainScreen(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
        .pushNamedAndRemoveUntil(RoutesConstants.mainContainer, (Route<dynamic> route) => false);
  }

  _saveValuesInMemory({
    required String userName,
    required String password,
  }) {
    //TODO
  }

  void doLoginCall(
      {required BuildContext context,
      required String userName,
      required String password,
      bool isBiometricLogin = false}) {
    //TODO

    _openMainScreen(context);
  }

  @override
  onDispose() {}
}
