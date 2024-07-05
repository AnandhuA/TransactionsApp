// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDcfxsww-ZtXiiPzOJx0qjqxhVZ-f8k3pU',
    appId: '1:796212995236:web:a57a31a61b726c68c83231',
    messagingSenderId: '796212995236',
    projectId: 'transcation-406f0',
    authDomain: 'transcation-406f0.firebaseapp.com',
    storageBucket: 'transcation-406f0.appspot.com',
    measurementId: 'G-FLL1XXMD47',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTk7AMWd6Q5wgxWpRJNJjEGz6JCOlF3II',
    appId: '1:796212995236:android:9e8d9637a6b4b221c83231',
    messagingSenderId: '796212995236',
    projectId: 'transcation-406f0',
    storageBucket: 'transcation-406f0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBZp0Q_2KdNkqTzMmttoVFIe3tqSLWTBK8',
    appId: '1:796212995236:ios:2a144d1de40eca26c83231',
    messagingSenderId: '796212995236',
    projectId: 'transcation-406f0',
    storageBucket: 'transcation-406f0.appspot.com',
    iosBundleId: 'com.example.transactionApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBZp0Q_2KdNkqTzMmttoVFIe3tqSLWTBK8',
    appId: '1:796212995236:ios:2a144d1de40eca26c83231',
    messagingSenderId: '796212995236',
    projectId: 'transcation-406f0',
    storageBucket: 'transcation-406f0.appspot.com',
    iosBundleId: 'com.example.transactionApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDcfxsww-ZtXiiPzOJx0qjqxhVZ-f8k3pU',
    appId: '1:796212995236:web:0ff50f02ed56fb46c83231',
    messagingSenderId: '796212995236',
    projectId: 'transcation-406f0',
    authDomain: 'transcation-406f0.firebaseapp.com',
    storageBucket: 'transcation-406f0.appspot.com',
    measurementId: 'G-VB95258TX9',
  );
}