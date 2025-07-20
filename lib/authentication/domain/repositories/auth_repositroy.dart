import 'package:app_vendor/authentication/domain/entities/login_response_entity.dart';
import 'package:app_vendor/authentication/domain/entities/user_login_entity.dart';
import 'package:app_vendor/authentication/domain/entities/user_register_entity.dart';

abstract class AuthRepository {
  // تسجيل مستخدم جديد
  Future<String> registerUser(UserRegisterEntity user);

  // تسجيل دخول مستخدم
  Future<LoginResponseEntity> loginUser(UserLoginEntity user);

  // حفظ التوكن
  Future<void> saveToken(String token);

  // استرجاع التوكن
  Future<String?> getToken();

  Future<void> saveshopId(String shopId);
  Future<String?> getshopId();

  Future<void> saveUserName(String userName);
  Future<String?> getUserName();

  // حذف التوكن (تسجيل الخروج)
  Future<void> clearToken();
}
