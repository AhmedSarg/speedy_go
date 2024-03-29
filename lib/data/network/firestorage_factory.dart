import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../firebase_options.dart';

abstract class FireStorageFactory {
  Future<FirebaseStorage> create();
}

class FireStorageFactoryImpl implements FireStorageFactory {

  @override
  Future<FirebaseStorage> create() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    return FirebaseStorage.instance;
  }
}
