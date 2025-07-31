// مزود نموذج التعديل مهيأ بقيم المنتج
import 'dart:io';
import 'package:app_vendor/authentication/application/providers/auth_notifier_provider.dart';
import 'package:app_vendor/category/presentation/widgets/category_dropdown.dart';
import 'package:app_vendor/core/presentation/widgets/reactive_text_input_widget.dart';
import 'package:app_vendor/mangment_products/application/product_state.dart';
import 'package:app_vendor/mangment_products/application/providers/product_notifier_provider.dart';
import 'package:app_vendor/mangment_products/domain/entities/product_entity.dart';
import 'package:app_vendor/mangment_products/domain/entities/update_product_entity.dart';
import 'package:app_vendor/permissions/permission_handler.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
    'image': FormControl<XFile?>(),
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

class EditProductScreen extends ConsumerWidget {
  final ProductEntity product;
  const EditProductScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(editProductFormProvider(product));
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
      } else if (next is ProductLoaded) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تم تعديل المنتج بنجاح'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("تعديل المنتج"),
      //   centerTitle: true,
      //   elevation: 0,
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
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
                  Text(
                    "Data Product".i18n,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const Divider(height: 24),
                  _buildLabel("تعديل اسم المنتج"),
                  const Gap(8),
                  ReactiveTextInputWidget(
                    //  hint: 'أدخل اسم المنتج',
                    hint: '',
                    controllerName: 'nameProduct',
                    prefixIcon: Icons.shopping_bag_outlined,
                  ),
                  const Gap(16),
                  _buildPriceCurrencyRow(isSmallScreen, isDarkMode),
                  const Gap(16),
                  _buildLabel("تعديل الفئة"),
                  const Gap(8),
                  const CategoryDropdown(formControlName: "categoryId"),
                  const Gap(16),
                  _buildLabel("تعديل الوصف"),
                  const Gap(8),
                  ReactiveTextInputWidget(
                    // hint: 'أدخل وصفاً للمنتج',
                    hint: '',
                    controllerName: 'descriptionProduct',
                    prefixIcon: Icons.description_outlined,
                  ),
                  const Gap(8),
                  ReactiveFormConsumer(
                    builder: (context, form, _) {
                      final imageControl =
                          form.control('image') as FormControl<XFile?>;
                      final pickedImage = imageControl.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            icon: const Icon(Icons.image),
                            label: Text(
                              pickedImage == null
                                  ? ' chess image'.i18n
                                  : 'update image'.i18n,
                            ),
                            onPressed: () async {
                              final granted =
                                  await PermissionsRequester.requestCameraAndStoragePermissions();
                              if (!granted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('يرجى منح صلاحيات التخزين'),
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
                          if (pickedImage != null)
                            Image.file(
                              File(pickedImage.path),
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            )
                          else
                            Image.network(
                              product.image,
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Text('لم يتم تحميل الصورة'),
                            ),
                        ],
                      );
                    },
                  ),
                  const Gap(24),
                  ReactiveFormConsumer(
                    builder: (context, form, child) {
                      final state = ref.watch(productNotifierProvider);
                      final isLoading = state is ProductLoading;

                      return ElevatedButton(
                        onPressed: form.valid && !isLoading
                            ? () async {
                                final name =
                                    form.control('nameProduct').value as String;
                                final price =
                                    form.control('priceProduct').value
                                        as double;
                                final desc =
                                    form.control('descriptionProduct').value
                                        as String? ??
                                    '';
                                final pickedImage =
                                    form.control('image').value as XFile?;
                                final image =
                                    pickedImage?.path ??
                                    product
                                        .image; // إذا لم يختر صورة، استخدم القديمة

                                final categoryId =
                                    form.control('categoryId').value as String;
                                final currency =
                                    form.control('currency').value as String;
                                final shopId = ref
                                    .read(authNotifierProvider)
                                    .shopId;

                                if (shopId == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'خطأ: لم يتم العثور على المتجر',
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                  return;
                                }

                                final updatedProduct = UpdateProductEntity(
                                  id: product.id,
                                  name: name,
                                  price: price,
                                  description: desc,
                                  image: image,
                                  categoryId: categoryId,
                                  currency: currency,
                                  shopId: shopId,
                                );

                                await ref
                                    .read(productNotifierProvider.notifier)
                                    .updateProduct(updatedProduct);
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
                            : Text(
                                'update product'.i18n,
                                style: TextStyle(fontSize: 16),
                              ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceCurrencyRow(bool isSmallScreen, bool isDarkMode) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: isSmallScreen ? 3 : 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel("تعديل السعر"),
              const Gap(8),
              ReactiveTextInputWidget(
                // hint: '0.00',
                hint: '',
                controllerName: 'priceProduct',
              ),
            ],
          ),
        ),
        const Gap(10),
        Expanded(
          flex: isSmallScreen ? 2 : 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel("currency"),
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
                  items: const [
                    DropdownMenuItem(
                      value: 'USD',
                      child: Text(
                        'USD',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'EUR',
                      child: Text(
                        'UER',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text.i18n,
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
    );
  }
}
