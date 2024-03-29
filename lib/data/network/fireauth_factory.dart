import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../firebase_options.dart';

abstract class FireAuthFactory {
  Future<FirebaseAuth> create();
}

class FireAuthFactoryImpl implements FireAuthFactory {

  @override
  Future<FirebaseAuth> create() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return FirebaseAuth.instance;
  }
}
