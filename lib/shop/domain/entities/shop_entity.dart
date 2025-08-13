import 'package:app_vendor/shop/domain/entities/shop_address_entity.dart';
import 'package:app_vendor/shop/domain/entities/shop_email_entity.dart';

enum ShopStatus { open, closed }

class ShopEntity {
  final String? id;
  final String firstName;
  final String lastName;
  final String phone;
  // final String addressId;
  final ShopStatus shopState;
  final ShopEmailEntity email;
  final ShopAddressEntity address;

  ShopEntity({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    // required this.addressId,
    required this.shopState,
    required this.email,
    required this.address,
  });
}
