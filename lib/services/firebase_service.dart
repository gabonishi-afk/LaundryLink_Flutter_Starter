import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Firebase integration placeholder.
///
/// The proposal uses Firebase Authentication and Cloud Firestore.
/// Run `flutterfire configure` first, then initialize Firebase in main.dart.
/// Move production authentication and CRUD operations into this service.
class FirebaseService {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseService({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : auth = auth ?? FirebaseAuth.instance,
        firestore = firestore ?? FirebaseFirestore.instance;

  Future<UserCredential> signIn(String email, String password) {
    return auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> register(String email, String password) {
    return auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() => auth.signOut();

  CollectionReference<Map<String, dynamic>> get users =>
      firestore.collection('users');

  CollectionReference<Map<String, dynamic>> get orders =>
      firestore.collection('orders');

  CollectionReference<Map<String, dynamic>> get notifications =>
      firestore.collection('notifications');
}
