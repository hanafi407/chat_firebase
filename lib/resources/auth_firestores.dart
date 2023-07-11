import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthFirestores {
  final firestore = FirebaseFirestore.instance;
  Future<String> username() async {
    var snap =
        await firestore.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
    var username = (snap as Map<String, dynamic>)['username'];
    return username;
  }
}
