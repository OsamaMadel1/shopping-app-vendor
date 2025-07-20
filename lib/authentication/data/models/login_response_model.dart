import 'package:app_vendor/authentication/domain/entities/login_response_entity.dart';

class LoginResponseModel {
  final String token;
  final String shopId;
  final String userName;

  LoginResponseModel({
    required this.token,
    required this.shopId,
    required this.userName,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    print("🧪 FULL RESPONSE: $data");
    return LoginResponseModel(
      token: data['token'],
      shopId: data['shopId'],
      userName: data['userName'],
    );
  }

  LoginResponseEntity toEntity() {
    return LoginResponseEntity(
      token: token,
      shopId: shopId,
      userName: userName,
    );
  }
}
