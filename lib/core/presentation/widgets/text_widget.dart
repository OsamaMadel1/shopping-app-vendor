import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;

  const TextWidget({
    super.key,
    required this.text,
    this.fontSize,
    this.color,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultStyle = theme.textTheme.bodyMedium;

    return Text(
      text.i18n,
      style: defaultStyle?.copyWith(
        fontSize: fontSize ?? defaultStyle.fontSize,
        color: color ?? theme.colorScheme.primary,
        fontWeight: fontWeight,
      ),
    );
  }
}
