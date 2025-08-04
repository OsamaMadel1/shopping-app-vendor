// mangment_product/application/providers/add_product_form_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

final addOffFormProvider = Provider.autoDispose<FormGroup>((ref) {
  return FormGroup({
    'nameOffer': FormControl<String>(
      validators: [Validators.required, Validators.minLength(2)],
    ),
    'descriptionOffer': FormControl<String>(
      validators: [Validators.required, Validators.minLength(5)],
    ),
    'discountPercentage': FormControl<double>(
      validators: [
        Validators.required,

        // Validators.number(),
        Validators.min(1),
        Validators.max(99),
      ],
    ),
    'newPrice': FormControl<double>(
      validators: [
        Validators.required,
        // Validators.number(),
        Validators.min(0.001),
      ],
    ),
    'oldPrice': FormControl<double>(
      validators: [
        Validators.required,
        // Validators.number(),
        Validators.min(0.001),
      ],
    ),
    'startDate': FormControl<DateTime>(validators: [Validators.required]),
    'endDate': FormControl<DateTime>(validators: [Validators.required]),
  });
});
