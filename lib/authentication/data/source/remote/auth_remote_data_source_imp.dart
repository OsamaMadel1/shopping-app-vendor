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

    // try {
    //   final response = await dio.post('/register', data: user.toJson());
    //   print("✅ Response status: ${response.statusCode}");
    //   print("✅ Response data: ${response.data}");
    //   if (response.statusCode == 200) {
    //     return response.data['data']['id'];
    //   } else {
    //     throw Exception('Signup failed: ${response.statusCode}');
    //   }
    // } on DioException catch (e) {
    //   print("❌ Dio exception details: ${e.toString()}");
    //   print("❌ Dio full error response: ${e.response}");
    //   if (e.response != null) {
    //     print("❌ Dio Error Response: ${e.response?.data}");
    //     throw Exception(
    //         'Signup error [${e.response?.statusCode}]: ${e.response?.data}');
    //   } else {
    //     print("❌ Dio Connection Error: ${e.message}");
    //     throw Exception('Signup connection error: ${e.message}');
    //   }
    // } catch (e) {
    //   print("❌ Unexpected Signup Error: $e");
    //   throw Exception('Unexpected signup error: $e');
    // }
  }

  @override
  Future<LoginResponseModel> login(UserLoginModel user) async {
    final response = await dio.post('Account/user/login', data: user.toJson());

    if (response.statusCode == 200 && response.data['succeeded'] == true) {
      return LoginResponseModel.fromJson(response.data);
    } else {
      throw Exception(response.data['errors'].toString());
    }

    // try {
    //   final response = await dio.post('/login', data: user.toJson());
    //   print("✅ Response status: ${response.statusCode}");
    //   print("✅ Response data: ${response.data}");
    //   if (response.statusCode == 200) {
    //     return LoginResponseModel.fromJson(response.data);
    //   } else {
    //     throw Exception('Login failed: ${response.statusCode}');
    //   }
    // } on DioException catch (e) {
    //   print("❌ Dio exception details: ${e.toString()}");
    //   print("❌ Dio full error response: ${e.response}");
    //   if (e.response != null) {
    //     print("❌ Dio Error Response: ${e.response?.data}");
    //     throw Exception(
    //         'Login error [${e.response?.statusCode}]: ${e.response?.data}');
    //   } else {
    //     print("❌ Dio Connection Error: ${e.message}");
    //     throw Exception('Login connection error: ${e.message}');
    //   }
    // } catch (e) {
    //   print("❌ Unexpected Login Error: $e");
    //   throw Exception('Unexpected login error: $e');
    // }
  }
}
