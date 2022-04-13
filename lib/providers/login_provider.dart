import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

class LoginFormProvider with ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String email = '';
  String password = '';
  bool isLoading = false;

  bool isValidForm() {
    final form = formKey.currentState!;
    if (form.validate()) {
      return true;
    }
    return false;
  }

  void loginUser(BuildContext context) async {
    try {
      final User? user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;

      if (user != null) {
        Navigator.pushNamed(context, 'home');
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(formatFirestoreError((e.code))),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void register(BuildContext context) async {
    String message = "";
    try {
      final User? user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;

      if (user != null) {
        message = "${user.email} succesfully registered!";
      }
    } on FirebaseAuthException {
      message = "Email already used. Go to login page";
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
