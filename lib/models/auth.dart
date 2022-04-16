import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:gym_routine/utils/utils.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChange => _auth.authStateChanges();

  Future<void> login(
      String email, String password, BuildContext context) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(formatFirestoreError((e.code))),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> register(
      String email, String password, BuildContext context) async {
    String message = "";
    try {
      _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        message = "Email already used. turn on registered switch";
      } else {
        message = formatFirestoreError(e.code);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  //  SignOut the current user
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
