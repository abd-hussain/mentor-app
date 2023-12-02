import 'dart:async';

// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:mentor_app/locator.dart';
import 'package:mentor_app/my_app.dart';
import 'package:dio/dio.dart';
import 'package:mentor_app/utils/constants/database_constant.dart';
import 'package:mentor_app/utils/error/exceptions.dart';
import 'package:mentor_app/utils/logger.dart';

void main() {
  runZonedGuarded(() async {
    logDebugMessage(message: 'Application Started ...');
    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator();

    await Hive.initFlutter();
    await MobileAds.instance.initialize();
    await Hive.openBox(DatabaseBoxConstant.userInfo);

    // await Firebase.initializeApp();

    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    runApp(const MyApp());
  }, (error, stackTrace) {
    if (error is DioError) {
      final exception = error.error;
      if (exception is HttpException) {
        Logger().wtf(exception.status);
        Logger().wtf(exception.message);
        Logger().wtf(exception.requestId);
      }
    }
  });
}
