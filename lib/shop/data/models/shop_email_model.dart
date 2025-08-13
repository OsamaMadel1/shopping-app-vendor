import 'package:app_vendor/shop/domain/entities/shop_email_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'shop_email_model.g.dart';

@JsonSerializable()
class ShopEmailModel {
  final String? shopId;
  final String? customerId;
  final String? deliveryCompanyId;
  final String userName;
  final String password;

  ShopEmailModel({
    this.shopId,
    this.customerId,
    this.deliveryCompanyId,
    required this.userName,
    required this.password,
  });

  factory ShopEmailModel.fromJson(Map<String, dynamic> json) =>
      _$ShopEmailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShopEmailModelToJson(this);

  ShopEmailEntity toEntity() {
    return ShopEmailEntity(
      shopId: shopId,
      customerId: customerId,
      deliveryCompanyId: deliveryCompanyId,
      userName: userName,
      password: password,
    );
  }

  factory ShopEmailModel.fromEntity(ShopEmailEntity entity) {
    return ShopEmailModel(
      shopId: entity.shopId,
      customerId: entity.customerId,
      deliveryCompanyId: entity.deliveryCompanyId,
      userName: entity.userName,
      password: entity.password,
    );
  }
}
