import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

final addCategoryFormProvider = Provider<FormGroup>((ref) {
  return FormGroup({
    'name': FormControl<String>(validators: [Validators.required]),
    'imageCategory': FormControl<XFile?>(validators: [Validators.required]),
  });
});
