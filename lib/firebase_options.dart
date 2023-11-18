// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA89om2WeKJ-brEbQT3OvC2l8cwp_idWpY',
    appId: '1:200690587482:web:d57d5c830cbba4d96d4563',
    messagingSenderId: '200690587482',
    projectId: 'helpera',
    authDomain: 'helpera.firebaseapp.com',
    storageBucket: 'helpera.appspot.com',
    measurementId: 'G-52TRCJSZJ2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDaUmDSDdBp9-z_U8IN8tSPz9oRpvHWew8',
    appId: '1:200690587482:android:6e539b09f00ca2546d4563',
    messagingSenderId: '200690587482',
    projectId: 'helpera',
    storageBucket: 'helpera.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC25pL0S8P2XC4sTstxxBARhfS_tvaXuLM',
    appId: '1:200690587482:ios:b65e1495eaa7cae56d4563',
    messagingSenderId: '200690587482',
    projectId: 'helpera',
    storageBucket: 'helpera.appspot.com',
    iosBundleId: 'com.helpera.mentorApp',
  );
}