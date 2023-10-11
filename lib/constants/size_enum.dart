enum SizeEnum {
  bit(value: 0),
  kb(value: 1024),
  mb(value: 1048576),
  gb(value: 1073741824),
  tb(value: 1099511627776);

  const SizeEnum({required this.value});
  final int value;
}
