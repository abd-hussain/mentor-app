import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mentor_app/utils/error/exceptions.dart';

class NetworkInfoService {
  ValueNotifier<bool> networkStateConnection = ValueNotifier<bool>(false);
  late ConnectivityResult result;
  Future<bool> isConnected() async {
    try {
      result = await Connectivity().checkConnectivity();
    } on PlatformException catch (e) {
      ConnectionException(message: 'Couldn\'t check connectivity status error: $e');
      return false;
    }

    if (result == ConnectivityResult.wifi || result == ConnectivityResult.mobile) {
      networkStateConnection.value = true;
      return true;
    } else {
      networkStateConnection.value = false;
      return false;
    }
  }
}
