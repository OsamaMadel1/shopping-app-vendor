// domain/value_objects/
enum GenderEntity {
  male,
  female;

  int toInt() => index;

  static GenderEntity fromInt(int value) => GenderEntity.values[value];
}
