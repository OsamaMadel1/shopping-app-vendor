import 'package:app_vendor/core/presentation/widgets/reactive_text_input_widget.dart';
import 'package:app_vendor/core/presentation/widgets/wid/colors.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:app_vendor/category/application/category_notifier.dart';
import 'package:app_vendor/category/application/providers/category_notifier_provider.dart';

class AddCategory extends ConsumerWidget {
  const AddCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.kPrimaryColor, // لون الخلفية
      ),
      child: IconButton(
        onPressed: () {
          final notifier = ref.read(categoryNotifierProvider.notifier);
          _showAddCategoryDialog(context, notifier);
        },
        icon: const Icon(Icons.add),
        tooltip: 'Add Category'.i18n,
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context, CategoryNotifier notifier) {
    final form = FormGroup({
      'name': FormControl<String>(validators: [Validators.required]),
    });

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Center(child: Text('Add Category'.i18n)),
        content: ReactiveForm(
          formGroup: form,
          child: ReactiveTextInputWidget(
            hint: 'name category'.i18n,
            controllerName: 'name',
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
                onPressed: () async {
                  if (form.valid) {
                    final name = form.control('name').value as String;
                    await notifier.addCategory(name);
                    Navigator.pop(context);
                  }
                },
                child: Text('add'.i18n),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
