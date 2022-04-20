extension StringX on String {
  capitalize() => (length > 1) ?
    this[0].toUpperCase() + substring(1).toLowerCase() : toUpperCase();
}

bool equalsIgnoreCase(String? string1, String? string2) {
  return string1?.toLowerCase() == string2?.toLowerCase();
}