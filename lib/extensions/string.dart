extension StringExt on String {
  bool get isBlank => trim().isEmpty;
  bool get isNotBlank => trim().isNotEmpty;
}
