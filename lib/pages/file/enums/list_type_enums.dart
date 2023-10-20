enum ListType {
  list,
  grid;

  const ListType();
  static ListType fromValue(String value) {
    return ListType.values.firstWhere((element) => element.name == value, orElse: () => ListType.list);
  }
}
