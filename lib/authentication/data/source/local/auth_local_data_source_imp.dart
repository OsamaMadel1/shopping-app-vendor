import 'package:app_vendor/authentication/data/source/local/auth_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences prefs;

  AuthLocalDataSourceImpl(this.prefs);

  static const _tokenKey = 'auth_token';
  static const _shopIdKey = 'shop_id';
  static const _userNameKey = 'user_name';

  @override
  Future<void> saveToken(String token) async {
    await prefs.setString(_tokenKey, token);
  }

  @override
  Future<String?> getToken() async {
    return prefs.getString(_tokenKey);
  }

  @override
  Future<void> saveshopId(String shopId) async {
    await prefs.setString(_shopIdKey, shopId);
  }

  @override
  Future<String?> getshopId() async {
    return prefs.getString(_shopIdKey);
  }

  @override
  Future<void> saveUserName(String userName) async {
    print("📥 saveUserName called with: $userName");
    await prefs.setString(_userNameKey, userName);
  }

  @override
  Future<String?> getUserName() async {
    return prefs.getString(_userNameKey);
  }

  Future<void> clearAll() async {
    await prefs.remove(_tokenKey);
    await prefs.remove(_shopIdKey);
    await prefs.remove(_userNameKey);
  }

  @override
  Future<void> clearToken() async {
    await clearAll();
  }
}
