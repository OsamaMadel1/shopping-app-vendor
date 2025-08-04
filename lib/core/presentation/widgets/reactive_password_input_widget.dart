import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

final showTextProvider = StateProvider<bool>((ref) => false);

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
  final String controllerName;
  final bool? showEye;
  final TextInputAction? textInputAction;
  Map<String, String Function(Object)>? validationMessages;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showText = ref.watch(showTextProvider);
    final theme = Theme.of(context); // ← للوصول إلى ألوان الثيم

    return ReactiveTextField(
      textInputAction: textInputAction ?? TextInputAction.done,
      obscureText: !showText,
      formControlName: controllerName,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        errorMaxLines: 3,
        filled: true,
        fillColor: theme.inputDecorationTheme.fillColor,
        labelStyle: theme.inputDecorationTheme.labelStyle,
        prefixIcon: Icon(Icons.lock, color: theme.iconTheme.color),
        labelText: hint.i18n,
        border: theme.inputDecorationTheme.border,
        focusedBorder: theme.inputDecorationTheme.focusedBorder,
        enabledBorder: theme.inputDecorationTheme.enabledBorder,
        errorBorder: theme.inputDecorationTheme.errorBorder,
        hintStyle: theme.inputDecorationTheme.hintStyle,
        suffixIcon: showEye == true
            ? IconButton(
                onPressed: () {
                  ref.read(showTextProvider.notifier).state = !showText;
                },
                icon: Icon(
                  showText ? Icons.visibility : Icons.visibility_off,
                  color: theme.iconTheme.color,
                ),
              )
            : null,
      ),
      validationMessages:
          validationMessages ??
          {
            "required": (error) => "Required".i18n,
            "email": (error) => "Email is not valid".i18n,
            "minLength": (error) => "Too short".i18n,
            "passwordMismatch": (error) => "Passwords do not match".i18n,
          },
    );
  }
}
