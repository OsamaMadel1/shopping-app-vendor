import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveCheckboxApartment extends StatelessWidget {
  const ReactiveCheckboxApartment({
    super.key,
    required this.controlName,
    required this.label,
  });

  final String controlName;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ReactiveCheckboxListTile(
        formControlName: controlName,
        title: Text(
          label.i18n,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodyMedium?.color,
          ),
        ),
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.zero,
        dense: true,
        activeColor: theme.colorScheme.primary,
        checkColor: theme.colorScheme.onPrimary,
      ),
    );
  }
}
