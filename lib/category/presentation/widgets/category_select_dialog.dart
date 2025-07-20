import 'package:app_vendor/category/application/providers/category_notifier_provider.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategorySelectDialog extends ConsumerStatefulWidget {
  final String? initialSelected; // فقط فئة واحدة مختارة

  const CategorySelectDialog({super.key, this.initialSelected});

  @override
  ConsumerState<CategorySelectDialog> createState() =>
      _CategorySelectDialogState();
}

class _CategorySelectDialogState extends ConsumerState<CategorySelectDialog> {
  String? selectedCategory; // فئة واحدة فقط

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.initialSelected;

    final state = ref.read(categoryNotifierProvider);
    final notifier = ref.read(categoryNotifierProvider.notifier);
    if (state.categories.isEmpty && !state.isLoading) {
      Future.microtask(() => notifier.fetchCategories());
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(categoryNotifierProvider);

    return AlertDialog(
      title: Center(child: const Text("فلتر المنتجات حسب الفئة المحددة")),
      content: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: state.categories.map((category) {
                  return RadioListTile<String>(
                    value: category.id,
                    groupValue: selectedCategory,
                    title: Text(category.name),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("cancel".i18n),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, selectedCategory);
              },
              child: Text("Ok".i18n),
            ),
          ],
        ),
      ],
    );
  }
}
