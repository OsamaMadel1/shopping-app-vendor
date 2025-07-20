abstract class AuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> clearToken();
  Future<void> saveshopId(String shopId);
  Future<String?> getshopId();
  Future<void> saveUserName(String userName);
  Future<String?> getUserName();
}
