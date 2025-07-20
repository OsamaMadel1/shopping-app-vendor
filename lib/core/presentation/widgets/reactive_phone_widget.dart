import 'package:app_vendor/core/presentation/widgets/wid/colors.dart';
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
    return ReactivePhoneFormField(
      formControlName: controllerName,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "xxxxxxxxx",
        suffixIcon: Icon(suffixIcon, color: AppColor.kPrimaryColor),
      ),
      isCountryButtonPersistent: true,
      countrySelectorNavigator: CountrySelectorNavigator.dialog(),
      isCountrySelectionEnabled: true,
    );
  }
}
