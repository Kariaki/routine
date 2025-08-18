import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum AppEnvironment { live, staging }

class AppConfig {
  AppConfig._();

  static final _androidConfig = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
    // apiKey: dotenv.get('firebaseAndroidApiKey'),
    // authDomain: dotenv.get('firebaseAuthDomain'),
    // appId: dotenv.get('firebaseAndroidAppId'),
    // messagingSenderId: dotenv.get('firebaseMessagingSenderId'),
    // measurementId: dotenv.get('firebaseMeasurementId'),
    // projectId: dotenv.get('firebaseProjectId'),
    // storageBucket: dotenv.get('firebaseStorageBucket'),
  );

  static final _iosConfig = FirebaseOptions(
    apiKey: dotenv.get('firebaseIOSApiKey'),
    authDomain: dotenv.get('firebaseAuthDomain'),
    appId: dotenv.get('firebaseIOSAppId'),
    messagingSenderId: dotenv.get('firebaseMessagingSenderId'),
    measurementId: dotenv.get('firebaseMeasurementId'),
    projectId: dotenv.get('firebaseProjectId'),
    storageBucket: dotenv.get('firebaseStorageBucket'),
    iosBundleId: "com.app.routine",
  );

  static FirebaseOptions? get firebaseOptions {
    if (Platform.isIOS) return _iosConfig;
    if (Platform.isAndroid) return _androidConfig;
    return null;
  }
}
