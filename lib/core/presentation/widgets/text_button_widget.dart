import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget({
    super.key,
    required this.text,
    this.onTap,
    this.size,
    this.foregroundColor,
  });

  final String text;
  final VoidCallback? onTap;
  final double? size;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    final baseStyle = Theme.of(context).textTheme.bodyMedium;

    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor:
            foregroundColor ?? Theme.of(context).colorScheme.primary,
      ),
      child: Text(
        text.i18n,
        style: baseStyle?.copyWith(
          fontSize: size ?? baseStyle.fontSize,
          color: foregroundColor ?? baseStyle.color,
        ),
      ),
    );
  }
}
