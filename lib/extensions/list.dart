extension listExt on List {
  List separated(element) {
    for (int i = length - 1; i > 0; i--) {
      insert(i, element);
    }
    return this;
  }
}
