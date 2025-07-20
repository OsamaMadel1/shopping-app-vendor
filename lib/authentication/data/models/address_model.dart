import 'package:app_vendor/authentication/domain/value_objects/address_entity.dart';

class AddressModel {
  final String city;
  final String street;
  final String floor;
  final String apartment;
  bool defaultAddress;

  AddressModel({
    required this.city,
    required this.street,
    required this.floor,
    required this.apartment,
    this.defaultAddress = true,
  });

  factory AddressModel.fromEntity(AddressEntity entity) {
    return AddressModel(
      city: entity.city,
      street: entity.street,
      floor: entity.floor,
      apartment: entity.apartment,
      //defaultAddress: entity.defaultAddress,
    );
  }

  Map<String, dynamic> toJson() => {
    'city': city,
    'street': street,
    'floor': floor,
    'apartment': apartment,
    'defaultAddress': defaultAddress,
  };
}
