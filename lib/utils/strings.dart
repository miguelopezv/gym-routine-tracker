extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

String formatFirestoreError(string) {
  return string.replaceAll('-', ' ').capitalize();
}
