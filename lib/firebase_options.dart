import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD7K4xB8xNzZxXz4Bem92hV0HQtFE0zBTg',
    appId: '1:331844342432:android:5ceda56796d74d4f11efc5',
    messagingSenderId: '331844342432',
    projectId: 'trackfollows-a3389',
    storageBucket: 'trackfollows-a3389.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD7K4xB8xNzZxXz4Bem92hV0HQtFE0zBTg',
    appId: '1:331844342432:android:5ceda56796d74d4f11efc5',
    messagingSenderId: '331844342432',
    projectId: 'trackfollows-a3389',
    storageBucket: 'trackfollows-a3389.firebasestorage.app',
    iosClientId: '',
    iosBundleId: '',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD7K4xB8xNzZxXz4Bem92hV0HQtFE0zBTg',
    appId: '1:331844342432:android:5ceda56796d74d4f11efc5',
    messagingSenderId: '331844342432',
    projectId: 'trackfollows-a3389',
    storageBucket: 'trackfollows-a3389.firebasestorage.app',
  );
}
