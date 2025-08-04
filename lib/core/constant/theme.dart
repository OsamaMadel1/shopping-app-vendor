import 'package:app_vendor/core/constant/color.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    primary: AppColor.kPrimaryColor,
    secondary: AppColor.kThirtColor,
    error: AppColor.kRedColor,
    surface: AppColor.kWhiteColor,
    onPrimary: Colors.white,
    onSurface: AppColor.kBlackColor,
    onSecondary: AppColor.kBlackColor,
    onError: Colors.white,
  ),
  scaffoldBackgroundColor: AppColor.kWhiteColor,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColor.kPrimaryColor,
    foregroundColor: Colors.white,
    centerTitle: true,
    elevation: 1,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColor.kPrimaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),
  ),
  iconTheme: IconThemeData(color: AppColor.kPrimaryColor),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: AppColor.kPrimaryColor),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColor.kPrimaryColor,
    foregroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w700,
      fontFamily: "SFProText-Bold",
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      fontFamily: "SFProText-Bold",
      color: Colors.black,
    ),
    bodySmall: TextStyle(fontSize: 15, color: Colors.grey),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade100,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade300),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColor.kPrimaryColor, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColor.kRedColor),
    ),
    hintStyle: TextStyle(color: Colors.grey.shade500),
    labelStyle: const TextStyle(color: Colors.black),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    checkColor: MaterialStateProperty.all(Colors.white),
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return AppColor.kPrimaryColor;
      }
      return Colors.grey.shade400;
    }),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return AppColor.kPrimaryColor;
      }
      return Colors.grey;
    }),
  ),
  switchTheme: SwitchThemeData(
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return AppColor.kPrimaryColor.withOpacity(0.5);
      }
      return Colors.grey.shade400;
    }),
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return AppColor.kPrimaryColor;
      }
      return Colors.grey.shade200;
    }),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    backgroundColor:
        Colors.white, // أو AppColor.kPrimaryColorDarkMode في darkTheme
    elevation: 10,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    primary: AppColor.kPrimaryColor,
    secondary: AppColor.kSecondColorDarkMode,
    error: AppColor.kRedColor,
    surface: AppColor.kPrimaryColorDarkMode,
    onPrimary: Colors.white,
    onSurface: Colors.white,
    onSecondary: Colors.white,
    onError: Colors.black,
  ),
  scaffoldBackgroundColor: AppColor.kPrimaryColorDarkMode,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColor.kPrimaryColor,
    foregroundColor: Colors.white,
    centerTitle: true,
    elevation: 1,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColor.kPrimaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),
  ),
  iconTheme: IconThemeData(color: AppColor.kPrimaryColor),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: AppColor.kPrimaryColor),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: AppColor.kPrimaryColor,
    foregroundColor: Colors.white,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.w700,
      fontFamily: "SFProText-Bold",
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w400,
      fontFamily: "SFProText-Bold",
      color: Colors.white,
    ),
    bodySmall: TextStyle(fontSize: 15, color: Colors.grey),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.grey.shade900,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade700),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.shade700),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColor.kPrimaryColor, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColor.kRedColor),
    ),
    hintStyle: TextStyle(color: Colors.grey.shade400),
    labelStyle: const TextStyle(color: Colors.white),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    checkColor: MaterialStateProperty.all(Colors.white),
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return AppColor.kPrimaryColor;
      }
      return Colors.grey.shade400;
    }),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return AppColor.kPrimaryColor;
      }
      return Colors.grey;
    }),
  ),
  switchTheme: SwitchThemeData(
    trackColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return AppColor.kPrimaryColor.withOpacity(0.5);
      }
      return Colors.grey.shade400;
    }),
    thumbColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return AppColor.kPrimaryColor;
      }
      return Colors.grey.shade200;
    }),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    backgroundColor: AppColor
        .kPrimaryColorDarkMode, // أو AppColor.kPrimaryColorDarkMode في darkTheme
    elevation: 10,
  ),
);
