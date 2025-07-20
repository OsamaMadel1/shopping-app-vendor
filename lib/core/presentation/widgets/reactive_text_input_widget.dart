import 'package:app_vendor/core/presentation/widgets/wid/colors.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

// ignore: must_be_immutable
class ReactiveTextInputWidget extends StatelessWidget {
  ReactiveTextInputWidget({
    super.key,
    required this.hint,
    this.validationMessages,
    required this.controllerName,
    this.textInputAction,
    this.prefixIcon,
  });
  final String hint;
  Map<String, String Function(Object)>? validationMessages;
  final String controllerName;
  final TextInputAction? textInputAction;
  final IconData? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: ReactiveTextField(
        textInputAction: textInputAction ?? TextInputAction.done,
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
          prefixIcon: Icon(prefixIcon, color: AppColor.kPrimaryColor),
          labelText: hint,
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
        ),
        validationMessages:
            validationMessages ??
            {
              "required": (o) => "Required".i18n,
              "email": (o) => "Email is not valid".i18n,
              "minLength": (o) => "Too short".i18n,
            },
      ),
    );
  }
}
