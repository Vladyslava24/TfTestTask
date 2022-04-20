extension StringExtensions on String {
  bool isNullOrEmpty() {
    return this == null || this.isEmpty;
  }

  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
