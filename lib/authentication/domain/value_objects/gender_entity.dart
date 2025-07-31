// domain/value_objects/
enum GenderEntity {
  male,
  Femalee;

  int toInt() => index;

  static GenderEntity fromInt(int value) => GenderEntity.values[value];
}
