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
    apiKey: 'AIzaSyB8dH5DtXKTpXAqFqhBYfG25g6-sEIRA_U',
    appId: '1:558367706951:web:f46794349fe68ded754662',
    messagingSenderId: '558367706951',
    projectId: 'pichere-54f9b',
    authDomain: 'pichere-54f9b.firebaseapp.com',
    storageBucket: 'pichere-54f9b.appspot.com',
    measurementId: 'G-2ZB7WN7R1P',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB2GgoBXWHzYxLNrJXFhwgLQq-mEDUFt3A',
    appId: '1:558367706951:android:666111d8214648c0754662',
    messagingSenderId: '558367706951',
    projectId: 'pichere-54f9b',
    storageBucket: 'pichere-54f9b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDjCHK53BcjWfr_6DRma3tjX-1TbC-65cw',
    appId: '1:558367706951:ios:3d4390f881fd1d16754662',
    messagingSenderId: '558367706951',
    projectId: 'pichere-54f9b',
    storageBucket: 'pichere-54f9b.appspot.com',
    iosClientId: '558367706951-oc4ohckd32kkhi8qco0ko4aaostucvt1.apps.googleusercontent.com',
    iosBundleId: 'com.bloom.pichere',
  );
}