import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ReactiveDatePickerWidget extends StatelessWidget {
  const ReactiveDatePickerWidget({
    super.key,
    required this.controlName,
    this.firstDate,
    this.lastDate,
    this.initialDatePickerMode,
  });

  final String controlName;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DatePickerMode? initialDatePickerMode;

  @override
  Widget build(BuildContext context) {
    return ReactiveDatePicker<DateTime>(
      formControlName: controlName,
      firstDate: firstDate ?? DateTime(1900),
      lastDate: lastDate ?? DateTime.now(),
      initialDatePickerMode: initialDatePickerMode ?? DatePickerMode.year,
      builder: (context, picker, child) {
        return InkWell(
          onTap: picker.showPicker,
          child: InputDecorator(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.calendar_today, color: Colors.teal),
            ),
            child: Text(
              picker.value == null
                  ? 'Select your birth date'.i18n
                  : picker.value!.toLocal().toString().split(' ')[0],
              style: TextStyle(color: Colors.teal[300]),
            ),
          ),
        );
      },
    );
  }
}
