import 'dart:io';
import 'package:app_vendor/authentication/application/providers/auth_notifier_provider.dart';
import 'package:app_vendor/category/presentation/widgets/add_category.dart';
import 'package:app_vendor/category/presentation/widgets/category_dropdown.dart';
import 'package:app_vendor/core/presentation/widgets/reactive_text_input_widget.dart';
import 'package:app_vendor/mangment_products/application/product_state.dart';
import 'package:app_vendor/mangment_products/application/providers/add_product_form_provider.dart';
import 'package:app_vendor/mangment_products/application/providers/product_notifier_provider.dart';
import 'package:app_vendor/mangment_products/domain/entities/product_entity.dart';
import 'package:app_vendor/permissions/permission_handler.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddProductScreen extends ConsumerWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final shopId = authState.shopId;
    final form = ref.watch(addProductFormProvider);
    final theme = Theme.of(context);

    ref.listen<ProductState>(productNotifierProvider, (previous, next) {
      if (next is ProductError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
      if (next is ProductLoaded) {
        Navigator.pop(context);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("تمت إضافة المنتج بنجاح")));
      }
    });

    return Scaffold(
      // appBar: AppBar(
      //   title: Center(child: const Text("add product")),
      //   centerTitle: true,
      //   elevation: 0,
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ReactiveForm(
                  formGroup: form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text(
                          "Data Product".i18n,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      const Divider(height: 24),

                      // اسم المنتج
                      _buildLabel("name product".i18n),
                      const Gap(8),
                      ReactiveTextInputWidget(
                        hint: 'enter name product'.i18n,
                        controllerName: 'nameProduct',
                        color: Colors.black,
                        prefixIcon: Icons.shopping_bag_outlined,
                      ),
                      const Gap(16),

                      // السعر والعملة
                      _buildPriceCurrencyRow(),
                      const Gap(16),

                      // الفئة
                      _buildLabel("Category".i18n),
                      const Gap(8),
                      Row(
                        children: [
                          Expanded(
                            child: CategoryDropdown(
                              formControlName: "categoryId",
                              labelText: "choose category".i18n,
                            ),
                          ),
                          SizedBox(width: 8),
                          AddCategory(),
                        ],
                      ),
                      const Gap(16),
                      // الوصف
                      _buildLabel("product description".i18n),
                      const Gap(8),
                      ReactiveTextInputWidget(
                        hint: 'Enter Product Description'.i18n,
                        controllerName: 'descriptionProduct',
                        color: Colors.black,
                        prefixIcon: Icons.description_outlined,
                      ),
                      const Gap(16),
                      // الصورة
                      ReactiveFormConsumer(
                        builder: (context, form, _) {
                          final imageControl =
                              form.control('image') as FormControl<XFile?>;
                          final image = imageControl.value;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                icon: const Icon(Icons.image),
                                label: Text('chess image'.i18n),
                                onPressed: () async {
                                  // طلب صلاحيات الكاميرا والتخزين
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
                                  // متابعة اختيار الصورة
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
                              if (image != null)
                                Image.file(
                                  File(image.path),
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                            ],
                          );
                        },
                      ),
                      const Gap(24),
                      // زر الإضافة
                      _buildSubmitButton(ref, form, theme),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceCurrencyRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("price".i18n),
        const Gap(8),
        ReactiveTextInputWidget(
          prefixIcon: Icons.price_change_outlined,
          hint: '0.00',
          controllerName: 'priceProduct',
          color: Colors.black,
        ),
        const Gap(10),
        _buildLabel("currency".i18n),
        const Gap(8),
        Directionality(
          textDirection: TextDirection.ltr,
          child: ReactiveDropdownField<String>(
            formControlName: 'currency',
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.currency_exchange, size: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              isDense: true,
            ),
            items: [
              DropdownMenuItem(
                value: 'USD',
                child: Text(
                  'USD',
                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              DropdownMenuItem(
                value: 'EUR',
                child: Text(
                  'EUR',
                  style: const TextStyle(fontSize: 12, color: Colors.black87),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton(WidgetRef ref, FormGroup form, ThemeData theme) {
    return ReactiveFormConsumer(
      builder: (context, form, child) {
        final state = ref.watch(productNotifierProvider);
        final isLoading = state is ProductLoading;
        return ElevatedButton(
          onPressed: form.valid && !isLoading
              ? () async {
                  final name = form.control('nameProduct').value as String;
                  final price = form.control('priceProduct').value as double;
                  final desc =
                      form.control('descriptionProduct').value as String;
                  final image = form.control('image').value as XFile?;
                  if (image == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('الرجاء اختيار صورة')),
                    );
                    return;
                  }
                  final categoryId = form.control('categoryId').value as String;
                  final currency = form.control('currency').value as String;
                  final shopId = ref.read(authNotifierProvider).shopId;

                  if (shopId == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('خطأ: لم يتم العثور على المتجر'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                    return;
                  }

                  final product = ProductEntity(
                    name: name,
                    price: price,
                    description: desc,
                    image: image.path,
                    categoryId: categoryId,
                    currency: currency,
                    shopId: shopId,
                  );

                  await ref
                      .read(productNotifierProvider.notifier)
                      .addProduct(product);
                }
              : null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : Text('add product'.i18n, style: TextStyle(fontSize: 16)),
        );
      },
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text.i18n,
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
    );
  }
}
