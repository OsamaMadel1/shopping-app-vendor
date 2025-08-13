import 'package:app_vendor/shop/data/models/shop_address_entity.dart';
import 'package:app_vendor/shop/data/models/shop_email_model.dart';
import 'package:app_vendor/shop/domain/entities/shop_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shop_model.g.dart';

@JsonSerializable()
class ShopModel {
  final String? id;
  final String firstName;
  final String lastName;
  final String phone;
  final int shopState;
  final ShopEmailModel email;
  final ShopAddressModel address;

  ShopModel({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.shopState,
    required this.email,
    required this.address,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) =>
      _$ShopModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopModelToJson(this);

  // تحويل من Model إلى Entity
  ShopEntity toEntity() {
    return ShopEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      shopState: _mapStateFromApi(shopState),
      email: email.toEntity(),
      address: address.toEntity(),
    );
  }

  // تحويل من Entity إلى Model
  factory ShopModel.fromEntity(ShopEntity entity) {
    return ShopModel(
      id: entity.id,
      firstName: entity.firstName,
      lastName: entity.lastName,
      phone: entity.phone,
      shopState: _mapStateToApi(entity.shopState),
      email: ShopEmailModel.fromEntity(entity.email),
      address: ShopAddressModel.fromEntity(entity.address),
    );
  }

  // محولات enum ↔ int
  static ShopStatus _mapStateFromApi(int value) {
    switch (value) {
      case 0:
        return ShopStatus.open;
      case 1:
        return ShopStatus.closed;
      default:
        throw Exception("Invalid shop state value: $value");
    }
  }

  static int _mapStateToApi(ShopStatus state) {
    switch (state) {
      case ShopStatus.open:
        return 0;
      case ShopStatus.closed:
        return 1;
    }
  }
}
