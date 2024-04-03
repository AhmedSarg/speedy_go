// import 'package:firebase_app_check/firebase_app_check.dart';
// import 'package:firebase_core/firebase_core.dart';
//
// import '../../firebase_options.dart';

abstract class FirebaseAppCheckFactory {
  Future<void> create();
}

class FirebaseAppCheckFactoryImpl implements FirebaseAppCheckFactory {

  @override
  Future<void> create() async {
    // await Firebase.initializeApp(
    //   options: DefaultFirebaseOptions.currentPlatform,
    // );
    // FirebaseAppCheck.instance.activate(
    //   androidProvider: AndroidProvider.playIntegrity
    // );
  }
}
