import 'dart:io';
import 'package:app_vendor/category/application/providers/add_category_form_provider.dart';
import 'package:app_vendor/category/application/providers/category_notifier_provider.dart';
import 'package:app_vendor/category/domain/entity/gategory_entity.dart';
import 'package:app_vendor/core/presentation/widgets/reactive_text_input_widget.dart';
import 'package:app_vendor/permissions/permission_handler.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddCategory extends ConsumerWidget {
  const AddCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.lightGreenAccent.shade400,
      ),
      child: IconButton(
        onPressed: () {
          final notifier = ref.read(categoryNotifierProvider.notifier);
          final form = ref.watch(addCategoryFormProvider);

          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Center(child: Text('Add Category'.i18n)),
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
                            // color: Colors.black,
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
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'يرجى منح الصلاحيات للكاميرا والتخزين'
                                                  .i18n,
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
                                        imageControl.updateValue(picked);
                                        imageControl.markAsDirty();
                                      }
                                    },
                                  ),
                                  const Gap(10),
                                  if (image != null) ...[
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        image.name,
                                        style: const TextStyle(fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        File(image.path),
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ],
                              );
                            },
                          ),
                          const Gap(15),
                          ReactiveFormConsumer(
                            builder: (context, form, _) {
                              return ElevatedButton(
                                onPressed: form.valid
                                    ? () async {
                                        final name =
                                            form.control('name').value
                                                as String;
                                        final image =
                                            form.control('imageCategory').value
                                                as XFile?;

                                        if (image == null) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'الرجاء اختيار صورة'.i18n,
                                              ),
                                            ),
                                          );
                                          return;
                                        }

                                        final category = CategoryEntity(
                                          name: name,
                                          image: image.path,
                                        );

                                        try {
                                          await notifier.addCategory(category);
                                          Navigator.pop(context);
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Category added successfully!'
                                                    .i18n,
                                              ),
                                            ),
                                          );
                                        } catch (e) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(e.toString()),
                                            ),
                                          );
                                        }
                                      }
                                    : null,
                                child: Text('add'.i18n),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Center(child: Text('cancel'.i18n)),
                  ),
                ],
              );
            },
          );
        },
        icon: Icon(Icons.add, color: Colors.white),
        tooltip: 'Add Category'.i18n,
      ),
    );
  }
}
