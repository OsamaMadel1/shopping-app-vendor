import 'package:app_vendor/authentication/data/models/address_model.dart';
import 'package:app_vendor/authentication/domain/entities/user_register_entity.dart';

class UserRegisterModel {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  final AddressModel address;

  UserRegisterModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    required this.address,
  });

  factory UserRegisterModel.fromEntity(UserRegisterEntity entity) {
    return UserRegisterModel(
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      phone: entity.phone,
      password: entity.password,
      address: AddressModel.fromEntity(entity.address),
    );
  }

  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'phone': phone,
    'password': password,
    'address': address.toJson(),
  };
}
