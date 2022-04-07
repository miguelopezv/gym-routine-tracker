import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey();

  String email = '';
  String password = '';

  // bool isLoading;
  bool isValidForm() {
    final form = formKey.currentState!;
    if (form.validate()) {
      return true;
    }
    return false;
  }
}
