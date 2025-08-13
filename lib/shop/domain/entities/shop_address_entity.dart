class ShopAddressEntity {
  final String? id;
  final String city;
  final String street;
  final String floor;
  final String apartment;
  // final bool defaultAddress;

  ShopAddressEntity({
    this.id,
    required this.city,
    required this.street,
    required this.floor,
    required this.apartment,
    // required this.defaultAddress,
  });
}
