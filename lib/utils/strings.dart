String emailPattern =
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

extension StringCapitalize on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension MailValidation on String {
  bool isValidEmail() {
    return RegExp(emailPattern).hasMatch(this);
  }
}

String formatFirestoreError(String string) {
  return string.replaceAll('-', ' ').capitalize();
}
