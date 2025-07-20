import 'package:app_vendor/mangment_products/domain/entities/product_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

// مزود خاص بنموذج تعديل المنتج يأخذ المنتج ويُرجع الفورم مهيأ بقيمه
final editProductFormProvider = Provider.family<FormGroup, ProductEntity>((
  ref,
  product,
) {
  return FormGroup({
    'nameProduct': FormControl<String>(
      value: product.name,
      validators: [Validators.required],
    ),
    'priceProduct': FormControl<double>(
      value: product.price,
      validators: [Validators.required],
    ),
    'descriptionProduct': FormControl<String>(value: product.description),
    'image': FormControl<String>(value: product.image),
    'categoryId': FormControl<String>(
      value: product.categoryId,
      validators: [Validators.required],
    ),
    'currency': FormControl<String>(
      value: product.currency,
      validators: [Validators.required],
    ),
  });
});
