import 'package:app_vendor/authentication/application/auth_state.dart';
import 'package:app_vendor/authentication/domain/entities/user_login_entity.dart';
import 'package:app_vendor/authentication/domain/entities/user_register_entity.dart';
import 'package:app_vendor/authentication/domain/usecase/clear_token_usecase.dart';
import 'package:app_vendor/authentication/domain/usecase/get_shop_id_use_case.dart';
import 'package:app_vendor/authentication/domain/usecase/get_token_usecase.dart';
import 'package:app_vendor/authentication/domain/usecase/get_user_name_use_case.dart';
import 'package:app_vendor/authentication/domain/usecase/login_user_usecase.dart';
import 'package:app_vendor/authentication/domain/usecase/register_user_usecase.dart';
import 'package:app_vendor/authentication/domain/usecase/save_shop_id_use_case.dart';
import 'package:app_vendor/authentication/domain/usecase/save_token_usecase.dart';
import 'package:app_vendor/authentication/domain/usecase/save_user_name_use_case.dart';
import 'package:app_vendor/utils/error_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final RegisterUserUseCase registerUser;
  final LoginUserUseCase loginUser;
  final SaveTokenUseCase saveToken;
  final GetTokenUseCase getToken;
  final ClearTokenUseCase clearToken;
  final SaveshopIdUseCase saveshopId;
  final GetshopIdUseCase getshopId;
  final SaveUserNameUseCase saveUserName;
  final GetUserNameUseCase getUserName;

  AuthNotifier({
    required this.saveshopId,
    required this.getshopId,
    required this.saveUserName,
    required this.getUserName,
    required this.registerUser,
    required this.loginUser,
    required this.saveToken,
    required this.getToken,
    required this.clearToken,
  }) : super(AuthState.initial());

  String? get currentshopId => state.shopId;
  String? get currentUserName => state.userName;
  Future<void> register(UserRegisterEntity user) async {
    print('🟡 [Register] بدأ تنفيذ التسجيل...');
    try {
      state = state.copyWith(status: AuthStatus.loading, error: null);
      final shopId = await registerUser(user);
      print('✅ [Register] تم إنشاء المستخدم بنجاح: $shopId');
      state = state.copyWith(status: AuthStatus.unauthenticated);
    } catch (e) {
      // state = state.copyWith(
      //   status: AuthStatus.error,
      //   error: e.toString(),
      //);
      final errorMessage = ErrorHandler.getMessage(e);
      print('❌ [Register] خطأ أثناء التسجيل: $errorMessage');
      state = state.copyWith(status: AuthStatus.error, error: errorMessage);
    }
  }

  Future<void> login(UserLoginEntity user) async {
    print('🟡 [Login] بدأ تنفيذ تسجيل الدخول...');
    try {
      state = state.copyWith(status: AuthStatus.loading, error: null);
      final response = await loginUser(user);
      print('✅ [Login] تسجيل الدخول ناجح. Token: ${response.token}');
      await saveToken(response.token);
      print('✅ [Login] تسجيل الدخول ناجح. shopId: ${response.shopId}');
      await saveshopId(response.shopId);
      print('✅ [Login] تسجيل الدخول ناجح. userName: ${response.userName}');
      await saveUserName(response.userName);
      state = state.copyWith(
        status: AuthStatus.authenticated,
        token: response.token,
        shopId: response.shopId,
        userName: response.userName,
      );
    } catch (e) {
      // state = state.copyWith(
      //   status: AuthStatus.error,
      //   error: e.toString(),
      // );
      final errorMessage = ErrorHandler.getMessage(e);
      print('❌ [Login] فشل تسجيل الدخول: $errorMessage');
      state = state.copyWith(status: AuthStatus.error, error: errorMessage);
    }
  }

  Future<void> checkAuthStatus() async {
    print('🔄 [Auth Check] التحقق من وجود توكن مخزن...');
    // final token = await getToken();
    // if (token != null) {
    //   state = state.copyWith(
    //     status: AuthStatus.authenticated,
    //     token: token,
    //   );
    // } else {
    //   state = state.copyWith(status: AuthStatus.unauthenticated);
    // }
    try {
      final token = await getToken();
      if (token != null) {
        final shopId = await getshopId();
        print("🟢 [Auth Check] shopId = $shopId");
        final userName = await getUserName();
        print("🟢 [Auth Check] UserName = $userName");
        print('✅ [Auth Check] توكن موجود: $token');
        state = state.copyWith(
          status: AuthStatus.authenticated,
          token: token,
          shopId: shopId, // ✅ تأكد أن لا تُمسح
          userName: userName,
        );
      } else {
        print('🔻 [Auth Check] لا يوجد توكن. المستخدم غير مسجل دخول.');
        state = state.copyWith(status: AuthStatus.unauthenticated);
      }
    } catch (e) {
      final errorMessage = ErrorHandler.getMessage(e);
      print('❌ [Auth Check] خطأ أثناء التحقق: $errorMessage');
      state = state.copyWith(status: AuthStatus.error, error: errorMessage);
    }
  }

  Future<void> logout() async {
    print('🚪 [Logout] تسجيل الخروج...');
    try {
      await clearToken();
      print('✅ [Logout] تم حذف التوكن والمعرفات.');
    } catch (e) {
      final errorMessage = ErrorHandler.getMessage(e);
      print('❌ [Logout] فشل في مسح البيانات: $errorMessage');
    }
    state = state.copyWith(
      status: AuthStatus.unauthenticated,
      token: null,
      shopId: null,
      userName: null,
    );
  }
}
