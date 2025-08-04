//import 'package:app/category/presentation/screens/categories_screen.dart';

//import 'package:app/core/presentation/screens/welcome_screen.dart';
import 'package:app_vendor/authentication/application/auth_state.dart';
import 'package:app_vendor/authentication/application/providers/auth_notifier_provider.dart';
// import 'package:app_vendor/authentication/data/providers/dio_provider.dart';
import 'package:app_vendor/authentication/presentation/screens/login_screen.dart';
import 'package:app_vendor/authentication/presentation/screens/singup_screen/signup_screen.dart';
import 'package:app_vendor/comments/presentation/comment_screen.dart';
import 'package:app_vendor/core/presentation/screens/home_screen.dart';
// import 'package:app_vendor/core/presentation/screens/onboarding_screen.dart';
import 'package:app_vendor/mangment_products/domain/entities/product_entity.dart';
import 'package:app_vendor/mangment_products/presentation/screens/add_product_screen.dart';
import 'package:app_vendor/mangment_products/presentation/screens/edit_product_screen.dart';
import 'package:app_vendor/mangment_products/presentation/screens/product_details_screen.dart';
import 'package:app_vendor/mangment_products/presentation/screens/product_screen.dart';
import 'package:app_vendor/offfers/presentation/screens/offs_screen.dart';
// import 'package:app_vendor/offer/domain/entity/offer_entity.dart';
// import 'package:app_vendor/offer/presentation/screens/offer_screen.dart';

import 'package:app_vendor/orders/presentation/screens/order_details_screen.dart';
import 'package:app_vendor/orders/presentation/screens/orders_screen.dart';
import 'package:app_vendor/settings/presentation/screens/settings_screen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final router = Provider<GoRouter>((ref) {
  final authState = ref.watch(
    authNotifierProvider,
  ); //المراقبة المباشرة لحالة المصادقة
  // final sharedPrefs = ref.watch(sharedPrefsProvider);
  // final seenOnboarding = sharedPrefs.getBool('seen_onboarding') ?? false;
  // print('seenOnboarding: $seenOnboarding');
  return GoRouter(
    // initialLocation: seenOnboarding ? "/login" : "/",
    initialLocation: '/homeScreen',
    observers: [BotToastNavigatorObserver()],
    redirect: (context, state) {
      //print('🔄 Redirect: ${state.matchedLocation}, Auth: ${authState.status}');
      //تحديد المسارات المحمية والعامة
      final isAuthenticated = authState.status == AuthStatus.authenticated;
      final isLoading = authState.status == AuthStatus.loading;
      final isLoggingIn =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/signUp';

      if (isLoading) {
        // ممكن ما تعيد توجيه، تعرض شاشة تحميل مكان الروتر (شاهد لاحقًا)
        return null;
      }
      // إذا المستخدم غير مسجل دخول وحاول يروح لشاشة رئيسية
      if (!isAuthenticated && !isLoggingIn) {
        return '/login'; // نعيده لشاشة الدخول
      }

      // if (seenOnboarding && state.matchedLocation == '/') {
      //   return '/login';
      // }

      // إذا المستخدم مسجل دخول ويحاول يروح لشاشات تسجيل الدخول أو التسجيل
      if (isAuthenticated && isLoggingIn) {
        //return '/mainScreen'; // نعيده للشاشة الرئيسية
        return '/homeScreen';
      }

      // تابع بدون إعادة توجيه
      return null;
    },
    routes: [
      // GoRoute(
      //   path: "/",
      //   name: "onboardingScreen",
      //   builder: (context, state) => OnboardingScreen(),
      // ),

      // =================================
      // ======== account ================
      // =================================
      GoRoute(
        path: "/signUp",
        name: "signUpScreen",
        builder: (context, state) => SignupScreen(),
      ),
      GoRoute(
        path: "/login",
        name: "loginScreen",
        builder: (context, state) => LoginScreen(),
      ),

      //-----------------------------------------
      // GoRoute(
      //   path: "/mainScreen",
      //   name: "mainScreen",
      //   builder: (context, state) => MainScreen(),
      // ),
      GoRoute(
        path: "/homeScreen",
        name: "homeScreen",
        builder: (context, state) => HomeScreen(),
      ),
      // =================================
      // ======== product ================
      // =================================
      GoRoute(
        path: "/productScreen",
        name: "productScreen",
        builder: (context, state) => ProductScreen(),
      ),
      GoRoute(
        path: "/addProductScreen",
        name: "addProductScreen",
        builder: (context, state) => AddProductScreen(),
      ),

      GoRoute(
        path: '/productDetailsScreen/:id',
        name: "productDetailsScreen",
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return ProductDetailsScreen(id: id);
        },
      ),
      GoRoute(
        path: '/editProduct',
        name: 'editProductScreen',
        builder: (context, state) {
          final product = state.extra as ProductEntity;
          return EditProductScreen(product: product);
        },
      ),
      // ------------------------------------

      // =================================
      // ======== order ==================
      // =================================
      GoRoute(
        path: "/ordersScreen",
        name: "ordersScreen",
        builder: (context, state) => OrdersScreen(),
      ),
      GoRoute(
        path: '/orderDetailsScreen/:id',
        name: 'orderDetailsScreen',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return OrderDetailsScreen(id: id);
        },
      ),
      //-----------------------------------
      GoRoute(
        path: '/settingsScreen',
        name: 'settingsScreen',
        builder: (context, state) {
          return SettingsScreen();
        },
      ),

      // =================================
      // ========== offers ==============
      // =================================
      GoRoute(
        path: "/offerScreen",
        name: "offerScreen",
        builder: (context, state) => const OffsScreen(),
      ),
      // GoRoute(
      //   path: "/addOfferScreen",
      //   name: "addOfferScreen",
      //   builder: (context, state) => const AddOfferScreen(),
      // ),
      // GoRoute(
      //   path: "/editOfferScreen",
      //   name: "editOfferScreen",
      //   builder: (context, state) {
      //     final offer = state.extra as OfferEntity;
      //     return EditOfferScreen(offer: offer);
      //   },
      // ),
      // GoRoute(
      //   path: "/offerDetailsScreen/:id",
      //   name: "offerDetailsScreen",
      //   builder: (context, state) {
      //     final id = state.pathParameters['id']!;
      //     return OfferDetailsScreen(offerId: id);
      //   },
      // ),

      // =================================
      // ======== category================
      // =================================
      // GoRoute(
      //   path: "/categoryScreen",
      //   name: "categoryScreen",
      //   builder: (context, state) => CategoriesScreen(),
      // ),
      //-----------------------------------

      // =================================
      // ======== comments ===============
      // =================================
      GoRoute(
        name: 'commentsScreen',
        path: '/comments/:productId',
        builder: (context, state) {
          final productId = state.pathParameters['productId']!;
          return CommentsScreen(productId: productId);
        },
      ),
    ],
  );
});
