import 'package:app_vendor/authentication/data/models/login_response_model.dart';
import 'package:app_vendor/authentication/data/models/user_login_model.dart';
import 'package:app_vendor/authentication/data/models/user_register_model.dart';
import 'package:app_vendor/authentication/data/source/remote/auth_remote_data_source.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<String> register(UserRegisterModel user) async {
    final response = await dio.post(
      'Account/user/register',
      options: Options(headers: {'Content-Type': 'application/json'}),
      data: user.toJson(),
    );

    if (response.statusCode == 200 && response.data['succeeded'] == true) {
      return response.data['data']['id'];
    } else {
      throw Exception(response.data['errors'].toString());
    }
  }

  @override
  Future<LoginResponseModel> login(UserLoginModel user) async {
    final response = await dio.post('Account/user/login', data: user.toJson());

    if (response.statusCode == 200 && response.data['succeeded'] == true) {
      return LoginResponseModel.fromJson(response.data);
    } else {
      throw Exception(response.data['errors'].toString());
    }
  }
}
