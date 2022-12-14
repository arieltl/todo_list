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
    apiKey: 'AIzaSyAGG3FURkS6TU8BM_oeNeyF5gI4P_bzje8',
    appId: '1:1065004644163:web:c0dd410b6531f519cce1f6',
    messagingSenderId: '1065004644163',
    projectId: 'todo-list-e7f89',
    authDomain: 'todo-list-e7f89.firebaseapp.com',
    storageBucket: 'todo-list-e7f89.appspot.com',
    measurementId: 'G-HNXBQ89Y8W',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC46fB3zsjChHViXIDPUvjKfNkxpGbyaiM',
    appId: '1:1065004644163:android:fabb610cd1de9347cce1f6',
    messagingSenderId: '1065004644163',
    projectId: 'todo-list-e7f89',
    storageBucket: 'todo-list-e7f89.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBwJDXdhKQ8VgpxUnYLa_n1WX_b0whZ1cA',
    appId: '1:1065004644163:ios:1135f0b7948c623dcce1f6',
    messagingSenderId: '1065004644163',
    projectId: 'todo-list-e7f89',
    storageBucket: 'todo-list-e7f89.appspot.com',
    iosClientId: '1065004644163-det4a802j72hnjuule8kdns1ecl24mb0.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoList',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBwJDXdhKQ8VgpxUnYLa_n1WX_b0whZ1cA',
    appId: '1:1065004644163:ios:1135f0b7948c623dcce1f6',
    messagingSenderId: '1065004644163',
    projectId: 'todo-list-e7f89',
    storageBucket: 'todo-list-e7f89.appspot.com',
    iosClientId: '1065004644163-det4a802j72hnjuule8kdns1ecl24mb0.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoList',
  );
}
