import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveDropdownGenderWidget<T> extends StatelessWidget {
  const ReactiveDropdownGenderWidget({
    super.key,
    required this.controllerName,
    required this.items,
    required this.itemBuilder,
    this.hintText,
    this.prefixIcon,
    this.validationMessages,
  });

  final String controllerName;
  final List<T> items;
  final Widget Function(T) itemBuilder;
  final String? hintText;
  final IconData? prefixIcon;
  final Map<String, String Function(Object)>? validationMessages;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputTheme = theme.inputDecorationTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: inputTheme.fillColor ?? theme.cardColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: inputTheme.enabledBorder is OutlineInputBorder
              ? (inputTheme.enabledBorder as OutlineInputBorder)
                    .borderSide
                    .color
              : Colors.grey.shade400,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ReactiveDropdownField<T>(
          formControlName: controllerName,
          items: items
              .map(
                (value) => DropdownMenuItem<T>(
                  value: value,
                  child: itemBuilder(value),
                ),
              )
              .toList(),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText?.i18n,
            hintStyle:
                inputTheme.hintStyle ??
                TextStyle(color: theme.hintColor, fontSize: 16),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: theme.iconTheme.color)
                : null,
          ),
          validationMessages: validationMessages,
          style: TextStyle(
            color: theme.textTheme.bodyMedium?.color,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          icon: Icon(Icons.arrow_drop_down, color: theme.iconTheme.color),
        ),
      ),
    );
  }
}
