import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mentor_app/locator.dart';
import 'package:mentor_app/models/authentication_models.dart';
import 'package:mentor_app/utils/logger.dart';
import 'package:mentor_app/utils/mixins.dart';

class AuthenticationService with Service {
  final LocalAuthentication? localAuthentication =
      locator<LocalAuthentication>();

  // Check if any hardware regarding authentication is available
  Future<bool> isBiometricAvailable() async {
    return await localAuthentication!.canCheckBiometrics &&
        await localAuthentication!
            .isDeviceSupported()
            .then((value) => value)
            // ignore: invalid_return_type_for_catch_error
            .catchError((error) => logDebugMessage(message: "+++ $error"));
  }

  // if authentication should be allowed
  Future<bool> shouldAllowBiometricAuthenticationToContinue(
      TargetPlatform? platform) async {
    if (platform == TargetPlatform.iOS) {
      return Future.value(true);
    } else if (platform == TargetPlatform.android) {
      // We need to check the biometric types available, if finger print is available, return true, otherwise, return false
      final listOfBiometricsAvailable = await getListOfBiometricTypes();
      var shouldAuthenticate = false;

      if (listOfBiometricsAvailable.isNotEmpty) {
        shouldAuthenticate = true;
      }
      return Future.value(shouldAuthenticate);
    } else {
      return Future.value(false);
    }
  }

  // To retrieve the list of biometric types
  // (if available).
  Future<List<BiometricType>> getListOfBiometricTypes() async {
    return localAuthentication!
        .getAvailableBiometrics()
        .then((value) => value)
        // ignore: invalid_return_type_for_catch_error
        .catchError((error) => logDebugMessage(message: error.toString()));
  }

  // Process of authentication user using
  // biometrics.
  Future<AuthenticationResult> authenticateUser(
      String localizedAuthenticationMessage) async {
    return localAuthentication!
        .authenticate(
      options: const AuthenticationOptions(
          biometricOnly: true, useErrorDialogs: true, stickyAuth: true),
      localizedReason: localizedAuthenticationMessage,
    )
        .then((value) async {
      return AuthenticationResult(
          success: value, errorMessage: value ? "" : "Authentication Failed");
    }).catchError((error) async {
      return AuthenticationResult(
          success: false, errorMessage: error.toString());
    });
  }

  Future<AuthenticationBiometricType> getAvailableBiometricTypes(
      TargetPlatform? platform) async {
    // Note : if isAvailable = false then we ignore the BiometricType

    AuthenticationBiometricType response = AuthenticationBiometricType(
        isAvailable: false, type: BiometricType.face);
    return await getListOfBiometricTypes().then((listOfBiometrics) {
      if (platform == TargetPlatform.iOS) {
        for (final biometricType in listOfBiometrics) {
          response = AuthenticationBiometricType(
              isAvailable: true, type: biometricType);
        }
      } else if (platform == TargetPlatform.android) {
        for (final biometricType in listOfBiometrics) {
          if (biometricType == BiometricType.face) {
            response = AuthenticationBiometricType(
                isAvailable: true, type: BiometricType.face);
          } else {
            response = AuthenticationBiometricType(
                isAvailable: true, type: BiometricType.fingerprint);
          }
        }
      }
      return Future.value(response);
    });
  }
}
