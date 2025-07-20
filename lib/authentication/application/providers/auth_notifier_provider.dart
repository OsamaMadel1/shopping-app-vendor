import 'package:app_vendor/authentication/application/auth_notifier.dart';
import 'package:app_vendor/authentication/application/auth_state.dart';
import 'package:app_vendor/authentication/application/providers/auth_repository_provider.dart';
import 'package:app_vendor/authentication/domain/usecase/clear_token_usecase.dart';
import 'package:app_vendor/authentication/domain/usecase/get_shop_id_use_case.dart';
import 'package:app_vendor/authentication/domain/usecase/get_token_usecase.dart';
import 'package:app_vendor/authentication/domain/usecase/get_user_name_use_case.dart';
import 'package:app_vendor/authentication/domain/usecase/login_user_usecase.dart';
import 'package:app_vendor/authentication/domain/usecase/register_user_usecase.dart';
import 'package:app_vendor/authentication/domain/usecase/save_shop_id_use_case.dart';
import 'package:app_vendor/authentication/domain/usecase/save_token_usecase.dart';
import 'package:app_vendor/authentication/domain/usecase/save_user_name_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((
  ref,
) {
  final repository = ref.watch(authRepositoryProvider);

  return AuthNotifier(
    registerUser: RegisterUserUseCase(repository),
    loginUser: LoginUserUseCase(repository),
    saveToken: SaveTokenUseCase(repository),
    getToken: GetTokenUseCase(repository),
    clearToken: ClearTokenUseCase(repository),
    saveshopId: SaveshopIdUseCase(repository),
    getshopId: GetshopIdUseCase(repository),
    saveUserName: SaveUserNameUseCase(repository),
    getUserName: GetUserNameUseCase(repository),
  );
});
/*
هذا هو الـ StateNotifier المسؤول عن إدارة حالة المصادقة (تسجيل الدخول، التسجيل، التوكن، إلخ).

يربط كل الـ Use Cases بالمستودع (Repository).

يتفاعل مع الواجهة (UI) عبر الحالة AuthState.
*/
