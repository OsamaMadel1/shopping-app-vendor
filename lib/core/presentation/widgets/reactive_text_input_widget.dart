import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

// ignore: must_be_immutable
class ReactiveTextInputWidget extends StatelessWidget {
  ReactiveTextInputWidget({
    super.key,
    required this.hint,
    this.validationMessages,
    this.controllerName,
    this.textInputAction,
    this.keyboardType,
    this.prefixIcon,
    this.color,
    this.readOnly,
    this.fillColor,
  });
  final String hint;
  final bool? readOnly;
  Map<String, String Function(Object)>? validationMessages;
  final String? controllerName;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  final IconData? prefixIcon;
  final Color? color;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: ReactiveTextField(
        readOnly: readOnly ?? false,
        textInputAction: textInputAction ?? TextInputAction.done,
        keyboardType: keyboardType ?? TextInputType.text,
        formControlName: controllerName,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 18, // زيادة المساحة الرأسية
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          errorMaxLines: 3,
          filled: true, // تفعيل الخلفية
          fillColor:
              Theme.of(context).inputDecorationTheme.fillColor ??
              fillColor, // لون خلفية فاتح
          labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
          hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
          // Theme.of(context).inputDecorationTheme.labelStyle?.copyWith(
          //   fontWeight: FontWeight.bold,
          //   fontSize: 16,
          //   color: color ?? Theme.of(context).colorScheme.primary,
          // ) ??
          // TextStyle(
          //   color: color ?? Theme.of(context).colorScheme.primary,
          //   fontWeight: FontWeight.bold,
          //   fontSize: 16,
          // ),
          prefixIcon: Icon(
            prefixIcon,
            color: Theme.of(context).colorScheme.primary,
          ),
          labelText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color:
                  Theme.of(context).inputDecorationTheme.enabledBorder
                      is OutlineInputBorder
                  ? (Theme.of(context).inputDecorationTheme.enabledBorder
                            as OutlineInputBorder)
                        .borderSide
                        .color
                  : Colors.grey[400]!,
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Theme.of(
                context,
              ).colorScheme.primary, // لون حدود عند التركيز
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
