import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// themes JSON
// class ThemeModeNotifier extends StateNotifier<ThemeMode> {
//   // ThemeModeNotifier() : super(ThemeMode.system);
//   ThemeModeNotifier() : super(ThemeMode.system) {
//     _loadThemeMode();
//   }
//   Future<void> _loadThemeMode() async {
//     final prefs = await SharedPreferences.getInstance();
//     final themeModeName = prefs.getString("themeMode");
//     state = ThemeMode.values
//         .where((element) => element.name == themeModeName)
//         .first;
//   }

//   Future<void> setThemeMode(ThemeMode themeMode) async {
//     state = themeMode; // All App refreshed

//     /// Thememode saved in prefs
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString("themeMode", themeMode.name);
//   }
// }

// final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>(
//   (ref) => ThemeModeNotifier(),
// );

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system) {
    _loadThemeMode();
  } // الوضع الافتراضي
  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeName = prefs.getString("themeMode");
    if (themeModeName != null) {
      try {
        state = ThemeMode.values.firstWhere(
          (e) => e.name == themeModeName,
          orElse: () =>
              ThemeMode.system, // fallback in case of unexpected value
        );
      } catch (_) {
        state = ThemeMode.system;
      }
    } else {
      state = ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    state = themeMode; // All App refreshed

    /// Thememode saved in prefs
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("themeMode", themeMode.name);
  }
}

final themeModeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
  (ref) => ThemeNotifier(),
);
