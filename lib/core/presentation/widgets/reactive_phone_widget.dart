import 'package:flutter/material.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';

class ReactivePhoneWidget extends StatelessWidget {
  const ReactivePhoneWidget({
    super.key,
    required this.controllerName,
    this.suffixIcon,
  });

  final String controllerName;
  final IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ReactivePhoneFormField(
      formControlName: controllerName,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        hintText: "xxxxxxxxx",
        suffixIcon: suffixIcon != null
            ? Icon(suffixIcon, color: theme.iconTheme.color)
            : null,
      ),
      isCountryButtonPersistent: true,
      countrySelectorNavigator: CountrySelectorNavigator.dialog(),
      isCountrySelectionEnabled: true,
    );
  }
}
