import 'dart:io';

import 'package:app_vendor/authentication/application/providers/auth_notifier_provider.dart';
import 'package:app_vendor/category/presentation/widgets/add_category.dart';
import 'package:app_vendor/category/presentation/widgets/category_dropdown.dart';
import 'package:app_vendor/core/presentation/widgets/reactive_text_input_widget.dart';
import 'package:app_vendor/core/presentation/widgets/wid/colors.dart';
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
    final isDarkMode = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;

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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'add product'.i18n,
          // style: theme.textTheme.headline6
          //     ?.copyWith(fontWeight: FontWeight.bold)
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          shadowColor: isDarkMode
              ? Colors.black54
              : Colors.grey.withOpacity(0.3),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ReactiveForm(
              formGroup: form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: _buildLabel(
                      "Data Product".i18n,
                      // style: theme.textTheme.headline6
                      //     ?.copyWith(fontWeight: FontWeight.bold)
                    ),
                  ),
                  const Divider(height: 32, thickness: 1.2),

                  // اسم المنتج
                  _buildLabel("name product".i18n),
                  const Gap(6),
                  ReactiveTextInputWidget(
                    hint: 'enter name product'.i18n,
                    controllerName: 'nameProduct',
                    color: Colors.black,
                    prefixIcon: Icons.shopping_bag_outlined,
                    // borderRadius: 12,
                    // fillColor: isDarkMode
                    //     ? Colors.grey.shade800
                    //     : Colors.grey.shade100,
                  ),
                  const Gap(20),

                  // السعر والعملة
                  _buildPriceCurrencyRow(),
                  const Gap(20),

                  // الفئة
                  _buildLabel("category".i18n),
                  const Gap(8),
                  Row(
                    children: [
                      Expanded(
                        child: CategoryDropdown(
                          formControlName: "categoryId",
                          labelText: "choose category".i18n,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const AddCategory(),
                    ],
                  ),
                  const Gap(20),

                  // الوصف
                  _buildLabel("product description".i18n),
                  const Gap(8),
                  ReactiveTextInputWidget(
                    hint: 'enter description product'.i18n,
                    controllerName: 'descriptionProduct',
                    color: Colors.black,
                    prefixIcon: Icons.description_outlined,
                    // maxLines: 3,
                    // borderRadius: 12,
                    // fillColor:
                    //     isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
                  ),
                  const Gap(20),

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
                  Gap(24),

                  // زر الإضافة
                  _buildSubmitButton(ref, form, theme),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceCurrencyRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("price".i18n),
        const Gap(6),
        ReactiveTextInputWidget(
          hint: '0.00',
          controllerName: 'priceProduct',
          color: Colors.black,
          prefixIcon: Icons.price_change_outlined,
          // keyboardType:
          //     const TextInputType.numberWithOptions(decimal: true),
          // borderRadius: 12,
          // fillColor: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
        ),

        const Gap(14),
        _buildLabel("currency".i18n),
        const Gap(6),
        Directionality(
          textDirection: TextDirection.ltr,
          child: ReactiveDropdownField<String>(
            formControlName: 'currency',
            hint: Text(
              'choose currency'.i18n,
              style: TextStyle(color: Colors.black),
            ),
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.currency_exchange, size: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              isDense: true,
              filled: true,
            ),
            items: [
              DropdownMenuItem(
                value: '\$',
                child: Text(
                  'دولار \$',
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              DropdownMenuItem(
                value: 'SY',
                child: Text(
                  'ليرة سورية SY',
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              DropdownMenuItem(
                value: 'T',
                child: Text(
                  'ليرة تركية T',
                  style: const TextStyle(fontSize: 14, color: Colors.black),
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
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
          ),
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.white,
                  ),
                )
              : Text(
                  'add product'.i18n,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        );
      },
    );
  }

  Widget _buildLabel(String text, {TextStyle? style}) {
    return Text(
      text.i18n,
      style:
          style ?? const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
    );
  }
}
