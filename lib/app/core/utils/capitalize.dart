String capitalize(String? s) {
  if (s == null || s.isEmpty) return "";
  return s[0].toUpperCase() + s.substring(1);
}
