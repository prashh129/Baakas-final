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
        return macos;
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
    apiKey: 'AIzaSyDDyUhf4s4MQw3mDUxGyW2VA6fq50Ql_wI',
    appId: '1:911112448037:web:d328ab85d2627e8c8937cc',
    messagingSenderId: '911112448037',
    projectId: 'baakas-197b9',
    authDomain: 'baakas-197b9.firebaseapp.com',
    storageBucket: 'baakas-197b9.firebasestorage.app',
    measurementId: 'G-LE23054Z6G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA0d_PDGTm3dr3fJU328WmQGf79z9C2zWw',
    appId: '1:911112448037:android:d2eb8b9b35ff8ae68937cc',
    messagingSenderId: '911112448037',
    projectId: 'baakas-197b9',
    storageBucket: 'baakas-197b9.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA6EubIa31tXF-hNkGj9Gul5mUzUu61xeU',
    appId: '1:911112448037:ios:9d97abeaf1d2aaf58937cc',
    messagingSenderId: '911112448037',
    projectId: 'baakas-197b9',
    storageBucket: 'baakas-197b9.firebasestorage.app',
    iosClientId: '911112448037-3v2orjbogjdu2u74fdu8i3rg9m9p3267.apps.googleusercontent.com',
    iosBundleId: 'com.example.baakasAdmin',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDyypc4MyqBBneptEWpF17u3s7cu8X4wIY',
    appId: '1:823307041176:ios:7b67fa8db6b2840d0653ed',
    messagingSenderId: '823307041176',
    projectId: 'codingwitht-c6d0f',
    databaseURL: 'https://codingwitht-c6d0f-default-rtdb.firebaseio.com',
    storageBucket: 'codingwitht-c6d0f.appspot.com',
    androidClientId: '823307041176-kun16mo723tugpbptbcbupndhaubv8cn.apps.googleusercontent.com',
    iosClientId: '823307041176-lp36pj2a155ifcmkeil3p2ch72krur3t.apps.googleusercontent.com',
    iosBundleId: 'com.example.cwtEcommerceAdminPanel.RunnerTests',
  );
}