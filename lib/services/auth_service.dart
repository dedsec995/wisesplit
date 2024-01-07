import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wisesplit/model/user.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

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
          email: fireUser.email ?? '',
          displayName: fireUser.displayName ?? '',
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
  Future<UserModel?> signUpUser(String email, String password) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      final User? fireUser = userCredential.user;
      if (fireUser != null) {
        return UserModel(
          id: fireUser.uid,
          email: fireUser.email ?? '',
          displayName: fireUser.displayName ?? '',
        );
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }

}
