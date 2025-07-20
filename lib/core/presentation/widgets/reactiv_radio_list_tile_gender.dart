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
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ReactiveRadioListTile<GenderEntity>(
        formControlName: controlName,
        value: gender,
        title: Text(
          label.i18n,
          style: TextStyle(fontSize: 14, color: Colors.teal[300]),
        ),
        visualDensity: VisualDensity.compact,
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
      ),
    );
  }
}
