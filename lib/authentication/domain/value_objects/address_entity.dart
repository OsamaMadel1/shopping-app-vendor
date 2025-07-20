class AddressEntity {
  final String city;
  final String street;
  final String floor;
  final String apartment;
  final bool defaultAddress;

  const AddressEntity({
    required this.city,
    required this.street,
    required this.floor,
    required this.apartment,
    this.defaultAddress = true,
  });
}
