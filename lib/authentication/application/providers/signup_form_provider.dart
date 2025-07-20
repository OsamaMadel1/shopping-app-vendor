//aplictioan/providers

import 'package:app_vendor/authentication/domain/value_objects/gender_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_phone_form_field/reactive_phone_form_field.dart';

final signUpFormProvider = Provider((ref) {
  return FormGroup(
    {
      "firstName": FormControl<String>(validators: [Validators.required]),
      "lastName": FormControl<String>(
        value: "",
        validators: [Validators.required],
      ),
      "email": FormControl<String>(
        validators: [
          Validators.minLength(8),
          Validators.maxLength(55),
          Validators.required,
          Validators.email,
        ],
      ),
      "password": FormControl<String>(
        validators: [Validators.required, Validators.minLength(8)],
      ),
      'confirmPassword': FormControl<String>(validators: [Validators.required]),
      "phone": FormControl<PhoneNumber?>(validators: [Validators.required]),
      // 'dateOfBirth': FormControl<DateTime>(validators: [Validators.required]),
      'city': FormControl<String>(validators: [Validators.required]),
      'street': FormControl<String>(validators: [Validators.required]),
      'floor': FormControl<String>(validators: [Validators.required]),
      'apartment': FormControl<String>(validators: [Validators.required]),
      // "hasApartment": FormControl<bool>(value: false),
      "gender": FormControl<GenderEntity>(validators: [Validators.required]),
    },
    validators: [CustumValidator()],
  );
});

class CustumValidator extends Validator<dynamic> {
  const CustumValidator();

  @override
  Map<String, dynamic>? validate(AbstractControl control) {
    final password = control.value['password'] as String?;
    final confirmPassword = control.value['confirmPassword'] as String?;

    if (password != null &&
        confirmPassword != null &&
        password != confirmPassword) {
      return {'passwordMismatch': true};
    }
    return null;
  }
}
