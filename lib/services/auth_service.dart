import 'package:firebase_auth/firebase_auth.dart';
import 'package:wisesplit/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Sign In
  Future<UserModel?> signInUser(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final User? fireUser = userCredential.user;
      if (fireUser != null) {
        return UserModel(
          id: fireUser.uid,
          email: fireUser.email,
          displayName: fireUser.displayName ?? "",
        );
      }
    } on FirebaseAuthException catch (e) {
      //wrong Email
      // showAlertDialog(context, "Error", e.code);
      print(e.toString());
    }
    return null;
  }

  // Sign Up
  Future<UserModel?> signUpUser(
      String username, String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? fireUser = userCredential.user;
      if (fireUser != null) {
        // Add Data to Database
        _firestore.collection('users').add({
          'id': fireUser.uid,
          'email': fireUser.email,
          'displayName': username,
        });
        return UserModel(
          id: fireUser.uid,
          email: fireUser.email,
          displayName: username,
        );
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    return null;
  }

  // SignOut
  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }

}
