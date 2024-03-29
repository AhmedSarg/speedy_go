import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../firebase_options.dart';

abstract class FirestoreFactory {
  Future<FirebaseFirestore> create();
}

class FirestoreFactoryImpl implements FirestoreFactory {

  @override
  Future<FirebaseFirestore> create() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return FirebaseFirestore.instance;
  }
}
