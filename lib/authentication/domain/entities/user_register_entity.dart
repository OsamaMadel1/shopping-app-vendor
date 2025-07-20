import 'package:app_vendor/authentication/domain/value_objects/address_entity.dart';

class UserRegisterEntity {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  final AddressEntity address;

  const UserRegisterEntity({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
    required this.address,
  });
}
