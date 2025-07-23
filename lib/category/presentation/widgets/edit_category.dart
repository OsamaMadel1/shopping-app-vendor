import 'dart:io';

import 'package:app_vendor/category/domain/entity/gategory_entity.dart';
import 'package:app_vendor/core/presentation/widgets/reactive_text_input_widget.dart';
import 'package:app_vendor/permissions/permission_handler.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:gap/gap.dart';
import 'package:app_vendor/category/application/providers/category_notifier_provider.dart';

Future<void> showEditCategoryDialog(
  BuildContext context,
  WidgetRef ref,
  CategoryEntity category,
) async {
  final notifier = ref.read(categoryNotifierProvider.notifier);

  final form = FormGroup({
    'name': FormControl<String>(
      value: category.name,
      validators: [Validators.required],
    ),
    'imageCategory': FormControl<XFile?>(validators: [Validators.required]),
  });

  await showDialog(
    context: context,
    builder: (_) {
      bool isSaving = false;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Center(child: Text('Edit Category'.i18n)),
            content: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 450),
              child: SingleChildScrollView(
                child: ReactiveForm(
                  formGroup: form,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ReactiveTextInputWidget(
                        hint: 'name category'.i18n,
                        controllerName: 'name',
                      ),
                      const Gap(10),
                      ReactiveFormConsumer(
                        builder: (context, form, _) {
                          final imageControl =
                              form.control('imageCategory')
                                  as FormControl<XFile?>;
                          final image = imageControl.value;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                icon: const Icon(Icons.image),
                                label: Text('choose image'.i18n),
                                onPressed: () async {
                                  bool granted =
                                      await PermissionsRequester.requestCameraAndStoragePermissions();
                                  if (!granted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'يرجى منح الصلاحيات للكاميرا والتخزين',
                                        ),
                                      ),
                                    );
                                    return;
                                  }

                                  final picker = ImagePicker();
                                  final picked = await picker.pickImage(
                                    source: ImageSource.gallery,
                                  );
                                  if (picked != null) {
                                    imageControl.value = picked;
                                  }
                                },
                              ),
                              const Gap(10),
                              if (image != null) ...[
                                Text(
                                  image.name,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(height: 5),
                                Image.file(
                                  File(image.path),
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('cancel'.i18n),
                  ),
                  ElevatedButton(
                    onPressed: isSaving || form.invalid
                        ? null
                        : () async {
                            final name = form.control('name').value as String;
                            final image =
                                form.control('imageCategory').value as XFile?;

                            if (image == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('الرجاء اختيار صورة'),
                                ),
                              );
                              return;
                            }

                            setState(() => isSaving = true);

                            final updatedCategory = CategoryEntity(
                              id: category.id,
                              name: name,
                              image: image.path,
                            );

                            try {
                              await notifier.updateCategory(updatedCategory);
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Category updated successfully!'.i18n,
                                  ),
                                ),
                              );
                            } catch (e) {
                              setState(() => isSaving = false);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(e.toString())),
                              );
                            }
                          },
                    child: isSaving
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text('save'.i18n),
                  ),
                ],
              ),
            ],
          );
        },
      );
    },
  );
}
