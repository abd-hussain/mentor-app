import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mentor_app/locator.dart';
import 'package:mentor_app/my_app.dart';
import 'package:dio/dio.dart';
import 'package:mentor_app/services/general/network_info_service.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/error/exceptions.dart';
import 'package:mentor_app/utils/logger.dart';

void main() {
  runZonedGuarded(() async {
    logDebugMessage(message: 'Application Started ...');
    WidgetsFlutterBinding.ensureInitialized();

    await setupLocator();

    await Hive.initFlutter();
    if (!kIsWeb) {
      await MobileAds.instance.initialize();
      await _setupFirebase();
    }
    await Hive.openBox(DatabaseBoxConstant.userInfo);

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    runApp(const MyApp());
  }, (error, stackTrace) {
    if (error is DioException) {
      final exception = error.error;
      if (exception is HttpException) {
        debugPrint("MAIN");
        debugPrint(exception.status.toString());
        debugPrint(exception.message);
        debugPrint(exception.requestId);
      }
    }
  });
}

Future<bool> _setupFirebase() async {
  NetworkInfoService networkInfoService = NetworkInfoService();
  bool hasConnectivity;
  hasConnectivity = await networkInfoService.checkConnectivityonLunching();

  if (hasConnectivity) {
    await Firebase.initializeApp();
  } else {
    networkInfoService.firebaseInitNetworkStateStreamControler.stream
        .listen((event) async {
      if (event && Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }
    });
  }
  networkInfoService.initNetworkConnectionCheck();

  return hasConnectivity;
}
