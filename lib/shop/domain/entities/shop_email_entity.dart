class ShopEmailEntity {
  final String? shopId;
  final String? customerId;
  final String? deliveryCompanyId;
  final String userName;
  final String password;

  ShopEmailEntity({
    this.shopId,
    this.customerId,
    this.deliveryCompanyId,
    required this.userName,
    required this.password,
  });
}
