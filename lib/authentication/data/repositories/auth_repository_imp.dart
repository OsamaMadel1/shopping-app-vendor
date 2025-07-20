import 'package:app_vendor/authentication/data/models/user_login_model.dart';
import 'package:app_vendor/authentication/data/models/user_register_model.dart';
import 'package:app_vendor/authentication/data/source/local/auth_local_data_source.dart';
import 'package:app_vendor/authentication/data/source/remote/auth_remote_data_source.dart';
import 'package:app_vendor/authentication/domain/entities/login_response_entity.dart';
import 'package:app_vendor/authentication/domain/entities/user_login_entity.dart';
import 'package:app_vendor/authentication/domain/entities/user_register_entity.dart';
import 'package:app_vendor/authentication/domain/repositories/auth_repositroy.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource; // login  and register
  final AuthLocalDataSource localDataSource; //save and delete and get and Token

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<String> registerUser(UserRegisterEntity user) {
    final model = UserRegisterModel.fromEntity(user);
    return remoteDataSource.register(model);
  }

  @override
  Future<LoginResponseEntity> loginUser(UserLoginEntity user) async {
    final model = UserLoginModel.fromEntity(user);
    final response = await remoteDataSource.login(model);
    return response.toEntity();
  }

  @override
  Future<void> saveToken(String token) {
    return localDataSource.saveToken(token);
  }

  @override
  Future<String?> getToken() {
    return localDataSource.getToken();
  }

  @override
  Future<void> clearToken() {
    return localDataSource.clearToken();
  }

  @override
  Future<void> saveshopId(String shopId) {
    return localDataSource.saveshopId(shopId);
  }

  @override
  Future<String?> getshopId() {
    return localDataSource.getshopId();
  }

  @override
  Future<void> saveUserName(String userName) {
    return localDataSource.saveUserName(userName);
  }

  @override
  Future<String?> getUserName() {
    return localDataSource.getUserName();
  }
}
