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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBNfsqQ6ssLbgoGjhH3O4inyFgVycMGAd0',
    appId: '1:677249099521:android:b89111802d13fe3ba01d00',
    messagingSenderId: '677249099521',
    projectId: 'glide-file-demo',
    storageBucket: 'glide-file-demo.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyALnaua9dcQGoDkbjamdnyIKZ1KMzln8FA',
    appId: '1:677249099521:ios:6fcfaeb849944c31a01d00',
    messagingSenderId: '677249099521',
    projectId: 'glide-file-demo',
    storageBucket: 'glide-file-demo.firebasestorage.app',
    iosBundleId: 'com.example.glideFileDemo',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAQHWGKJqVneJQDZUijnRD3mAToRcHgm0g',
    appId: '1:677249099521:web:c1694bb183deea48a01d00',
    messagingSenderId: '677249099521',
    projectId: 'glide-file-demo',
    authDomain: 'glide-file-demo.firebaseapp.com',
    storageBucket: 'glide-file-demo.firebasestorage.app',
    measurementId: 'G-XWVQN5JQ3J',
  );
}
