// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBs6Rsss_TdiJP2ivRyUqXsWGvQJVg-jxI',
    appId: '1:276972422623:web:1eba74ec11d3373d1db06a',
    messagingSenderId: '276972422623',
    projectId: 'bookapp-6f8f5',
    authDomain: 'bookapp-6f8f5.firebaseapp.com',
    storageBucket: 'bookapp-6f8f5.appspot.com',
    measurementId: 'G-CSHL9W061M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAjw0tbNhVgKItL51birXTGAOhFqXNnhgc',
    appId: '1:276972422623:android:8c2c831ea54a98dd1db06a',
    messagingSenderId: '276972422623',
    projectId: 'bookapp-6f8f5',
    storageBucket: 'bookapp-6f8f5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAJsF4ghofLPVV1PqL2skY4xetiNXGqqu8',
    appId: '1:276972422623:ios:fe43f734eb9863901db06a',
    messagingSenderId: '276972422623',
    projectId: 'bookapp-6f8f5',
    storageBucket: 'bookapp-6f8f5.appspot.com',
    iosClientId: '276972422623-7esf0k2rf900kk340j36rfb58r3qkb5p.apps.googleusercontent.com',
    iosBundleId: 'com.quicks.bookapp',
  );
}