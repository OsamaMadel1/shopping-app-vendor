import 'package:app_vendor/authentication/application/providers/auth_notifier_provider.dart';
import 'package:app_vendor/authentication/data/providers/dio_provider.dart';
import 'package:app_vendor/roters.dart';
import 'package:app_vendor/translations.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i18n_extension/i18n_extension.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPrefs = await SharedPreferences.getInstance();

  // Language ------------------------------------------------------------------
  await MyI18n.loadTranslations();

  // استرجاع اللغة المحفوظة أو التعيين الافتراضي
  final savedLanguage = sharedPrefs.getString("language") ?? "ar-SA";
  final localeParts = savedLanguage.split("-");
  final locale = Locale(localeParts[0], localeParts[1]);
  Intl.defaultLocale = savedLanguage;
  // ---------------------------------------------------------------------------
  runApp(
    ProviderScope(
      overrides: [sharedPrefsProvider.overrideWithValue(sharedPrefs)],
      child: I18n(initialLocale: locale, child: MyApp()),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref.read(authNotifierProvider.notifier).checkAuthStatus();
      setState(() {
        _isInitialized = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      // شاشة انتظار بسيطة
      return const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }

    return MaterialApp.router(
      theme: ThemeData(fontFamily: 'Cairo'),
      builder: BotToastInit(),
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(router),
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'SA')],
      locale: I18n.of(context).locale,
    );
  }
}
