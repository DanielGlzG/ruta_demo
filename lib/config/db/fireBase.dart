import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FireBaseFireStore {
  // Singleton pattern for FirestoreService
  static final FireBaseFireStore _instance = FireBaseFireStore._internal();

  // Private constructor
  FireBaseFireStore._internal();

  // Factory constructor to return the same instance
  factory FireBaseFireStore() {
    return _instance;
  }

  // Method to initialize Firebase
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    print('Firebase initialized');
  }

  // Getter to access Firestore instance
  FirebaseFirestore get firestoreInstance {
    return FirebaseFirestore.instance;
  }
}
