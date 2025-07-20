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
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ReactiveCheckboxListTile(
        formControlName: controlName,
        title: Text(
          label.i18n,
          style: TextStyle(fontSize: 14, color: Colors.teal[700]),
        ),
        controlAffinity: ListTileControlAffinity.leading,
        contentPadding: EdgeInsets.zero,
        dense: true,
      ),
    );
  }
}
