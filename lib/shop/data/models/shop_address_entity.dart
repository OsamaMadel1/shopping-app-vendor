import 'package:app_vendor/shop/domain/entities/shop_address_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'shop_address_entity.g.dart';

@JsonSerializable()
class ShopAddressModel {
  final String? id;
  final String city;
  final String street;
  final String floor;
  final String apartment;
  // final bool defaultAddress;

  ShopAddressModel({
    this.id,
    required this.city,
    required this.street,
    required this.floor,
    required this.apartment,
    // required this.defaultAddress,
  });

  factory ShopAddressModel.fromJson(Map<String, dynamic> json) =>
      _$ShopAddressModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopAddressModelToJson(this);

  ShopAddressEntity toEntity() {
    return ShopAddressEntity(
      id: id,
      city: city,
      street: street,
      floor: floor,
      apartment: apartment,
      // defaultAddress: defaultAddress,
    );
  }

  factory ShopAddressModel.fromEntity(ShopAddressEntity entity) {
    return ShopAddressModel(
      id: entity.id,
      city: entity.city,
      street: entity.street,
      floor: entity.floor,
      apartment: entity.apartment,
      // defaultAddress: entity.defaultAddress,
    );
  }
}
