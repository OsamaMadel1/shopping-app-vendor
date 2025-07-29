import 'package:app_vendor/offfers/domain/entity/off_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

// مزود خاص بنموذج تعديل المنتج يأخذ العرض ويُرجع الفورم مهيأ بقيمه
final editOffFormProvider = Provider.family<FormGroup, OffEntity>((ref, off) {
  return FormGroup({
    'nameOffer': FormControl<String>(
      value: off.name,
      validators: [Validators.required],
    ),
    'descriptionOffer': FormControl<String>(value: off.description),
    'discountPercentage': FormControl<double>(
      value: off.discountPercentage,
      validators: [
        Validators.required,
        // Validators.number(),
        Validators.min(0.1),
      ],
    ),
    'newPrice': FormControl<double>(
      value: off.newPrice,
      validators: [
        Validators.required, // Validators.number(),
        Validators.min(0.1),
      ],
    ),
    'startDate': FormControl<DateTime>(
      value: off.startDate,
      validators: [Validators.required],
    ),
    'endDate': FormControl<DateTime>(
      value: off.endDate,
      validators: [Validators.required],
    ),
    'oldPrice': FormControl<double>(), // لا نحتاج تحقق لأنه يُحسب تلقائيًا
  });
});
