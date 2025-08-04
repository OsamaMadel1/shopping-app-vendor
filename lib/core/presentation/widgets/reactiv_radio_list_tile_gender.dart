import 'package:app_vendor/authentication/domain/value_objects/gender_entity.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactivRadioListTileGender extends StatelessWidget {
  const ReactivRadioListTileGender({
    super.key,
    required this.controlName,
    required this.gender,
    required this.label,
  });

  final String controlName;
  final GenderEntity gender;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ReactiveRadioListTile<GenderEntity>(
        formControlName: controlName,
        value: gender,
        title: Text(
          label.i18n,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.textTheme.bodyMedium?.color,
          ),
        ),
        visualDensity: VisualDensity.compact,
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: theme.colorScheme.primary,
      ),
    );
  }
}
