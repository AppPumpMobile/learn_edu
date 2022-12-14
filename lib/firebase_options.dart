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
    apiKey: 'AIzaSyCU6Z3VaYa_q6p-oPvZkAU7c0YvootAYaY',
    appId: '1:352244220264:web:25abcddb840054224116dd',
    messagingSenderId: '352244220264',
    projectId: 'learn-academy-5048a',
    authDomain: 'learn-academy-5048a.firebaseapp.com',
    storageBucket: 'learn-academy-5048a.appspot.com',
    measurementId: 'G-RE7NHT6YMY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDYSWO5Qm0SeUHSKxaOJMKwEjAO6wbHldU',
    appId: '1:352244220264:android:86f07b21394c07474116dd',
    messagingSenderId: '352244220264',
    projectId: 'learn-academy-5048a',
    storageBucket: 'learn-academy-5048a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA-T-MKoAQ_MBXMOGeai1R8gJLsrm3zWws',
    appId: '1:352244220264:ios:1370bdf875a0144a4116dd',
    messagingSenderId: '352244220264',
    projectId: 'learn-academy-5048a',
    storageBucket: 'learn-academy-5048a.appspot.com',
    iosClientId: '352244220264-mr2rrg7gcsgtcckhgmjoaie99qfc1562.apps.googleusercontent.com',
    iosBundleId: 'com.developer.learnacadmy',
  );
}
