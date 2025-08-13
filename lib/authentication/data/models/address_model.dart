import 'package:app_vendor/authentication/domain/value_objects/address_entity.dart';

class AddressModel {
  final String city;
  final String street;
  final String floor;
  final String apartment;
  final bool defaultAddress;

  AddressModel({
    required this.city,
    required this.street,
    required this.floor,
    required this.apartment,
    required this.defaultAddress,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      city: json['city'],
      street: json['street'],
      floor: json['floor'],
      apartment: json['apartment'],
      defaultAddress: json['defaultAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'street': street,
      'floor': floor,
      'apartment': apartment,
      'defaultAddress': defaultAddress,
    };
  }

  factory AddressModel.fromEntity(AddressEntity entity) {
    return AddressModel(
      city: entity.city,
      street: entity.street,
      floor: entity.floor,
      apartment: entity.apartment,
      defaultAddress: entity.defaultAddress,
    );
  }

  AddressEntity toEntity() {
    return AddressEntity(
      city: city,
      street: street,
      floor: floor,
      apartment: apartment,
      defaultAddress: defaultAddress,
    );
  }
}
