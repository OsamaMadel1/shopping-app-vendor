import 'package:app_vendor/core/presentation/widgets/wid/colors.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

// ignore: must_be_immutable
class ReactivePasswordInputWidget extends ConsumerWidget {
  ReactivePasswordInputWidget({
    super.key,
    required this.hint,
    this.validationMessages,
    required this.controllerName,
    this.showEye,
    this.textInputAction,
  });
  final String hint;
  Map<String, String Function(Object)>? validationMessages;
  final String controllerName;
  final bool? showEye;
  final TextInputAction? textInputAction;

  @override
  Widget build(BuildContext context, ref) {
    var showText = ref.watch(showTextProvider);
    return ReactiveTextField(
      textInputAction: textInputAction ?? TextInputAction.done,
      obscureText: !showText,
      formControlName: controllerName,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18, // زيادة المساحة الرأسية
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        errorMaxLines: 3,
        filled: true, // تفعيل الخلفية
        fillColor: Colors.grey[100], // لون خلفية فاتح
        labelStyle: TextStyle(
          color: AppColor.kPrimaryColor,
          fontWeight: FontWeight.bold, // خط عريض
          fontSize: 16, // حجم أكبر للنص
        ),

        prefixIcon: Icon(Icons.lock, color: AppColor.kPrimaryColor),
        labelText: hint.i18n,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey[400]!, // لون حدود أفتح
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColor.kPrimaryColor, // لون حدود عند التركيز
            width: 2,
          ),
        ),
        suffixIcon: showEye == true
            ? IconButton(
                onPressed: () {
                  ref.read(showTextProvider.notifier).state = !showText;
                },
                icon: showText == true
                    ? Icon(Icons.remove_red_eye)
                    : Icon(Icons.visibility_off),
              )
            : null,
      ),
      validationMessages:
          validationMessages ??
          {
            "required": (error) => "Required".i18n,
            "email": (error) => "Email is not valid".i18n,
            "minLength": (error) => "Too short".i18n,
            'passwordMismatch': (error) => 'Passwords do not match'.i18n,
          },
    );
  }
}

final showTextProvider = StateProvider<bool>((ref) => false);
