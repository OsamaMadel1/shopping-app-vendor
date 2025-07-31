import 'dart:io';
import 'package:app_vendor/core/presentation/widgets/button_widget.dart';
import 'package:app_vendor/core/presentation/widgets/reactive_text_input_widget.dart';
import 'package:app_vendor/mangment_products/domain/entities/product_entity.dart';
import 'package:app_vendor/offfers/application/providers/add_off_form_provider.dart';
import 'package:app_vendor/offfers/application/providers/off_notifier_provider.dart';
import 'package:app_vendor/offfers/domain/entity/off_entity.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddOffScreen extends ConsumerStatefulWidget {
  final ProductEntity product;
  final XFile? initialImage;

  const AddOffScreen({super.key, required this.product, this.initialImage});

  @override
  ConsumerState<AddOffScreen> createState() => _AddOfferScreenState();
}

class _AddOfferScreenState extends ConsumerState<AddOffScreen> {
  late XFile? selectedImage;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    selectedImage = widget.initialImage;
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        selectedImage = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(addOffFormProvider);
    final notifier = ref.read(offNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Add Offer'.i18n))),
      body: ReactiveForm(
        formGroup: form,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // صورة العرض
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                  color: Colors.grey[100],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: selectedImage != null
                      ? Image.file(
                          File(selectedImage!.path),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.image, size: 40, color: Colors.grey),
                            SizedBox(height: 8),
                            Text(
                              'Choose Image'.i18n,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),

            const Gap(16),
            ReactiveTextInputWidget(
              prefixIcon: Icons.title,
              hint: 'Offer Name'.i18n,
              controllerName: 'nameOffer',
              color: Colors.black87,
            ),
            const Gap(12),
            ReactiveTextInputWidget(
              prefixIcon: Icons.description,
              hint: 'Description'.i18n,
              controllerName: 'descriptionOffer',
              color: Colors.black87,
            ),
            const Gap(12),
            ReactiveTextInputWidget(
              prefixIcon: Icons.percent,
              hint: 'Discount Percentage'.i18n,
              controllerName: 'discountPercentage',
              color: Colors.black87,
            ),
            const Gap(12),
            ReactiveTextInputWidget(
              prefixIcon: Icons.price_change,
              controllerName: 'newPrice',
              hint: 'New Price'.i18n,
              textInputAction: TextInputAction.done,
              color: Colors.black87,
            ),
            const Gap(12),

            // التاريخ
            Row(
              children: [
                Expanded(child: _buildDatePicker('startDate', 'Start Date')),
                const Gap(12),
                Expanded(child: _buildDatePicker('endDate', 'End Date')),
              ],
            ),

            const SizedBox(height: 24),

            isSaving
                ? const Center(child: CircularProgressIndicator())
                : ButtonWidget(
                    text: 'Save Offer'.i18n,
                    width: 50,
                    onTap: () async {
                      if (!form.valid) {
                        form.markAllAsTouched();
                        return;
                      }

                      if (selectedImage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(' Please select an image'.i18n),
                          ),
                        );
                        return;
                      }

                      if (widget.product.id == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('حدث خطأ في المنتج')),
                        );
                        return;
                      }

                      setState(() => isSaving = true);

                      final off = OffEntity(
                        shopId: widget.product.shopId,
                        productId: widget.product.id!,
                        name: form.control('nameOffer').value,
                        description: form.control('descriptionOffer').value,
                        discountPercentage: form
                            .control('discountPercentage')
                            .value,
                        newPrice: form.control('newPrice').value,
                        startDate: form.control('startDate').value,
                        endDate: form.control('endDate').value,
                        image: selectedImage!.path,
                      );

                      await notifier.addOff(off);

                      if (!mounted) return;
                      Navigator.pop(context, true);
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker(String name, String label) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade500),
        borderRadius: BorderRadius.circular(25),
      ),
      child: ReactiveDatePicker<DateTime>(
        formControlName: name,
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
        builder: (context, picker, child) {
          return ListTile(
            title: Center(child: Text(label.i18n)),
            subtitle: picker.value == null
                ? Center(child: Text('Choose a date'.i18n))
                : Center(child: Text(DateFormat.yMd().format(picker.value!))),
            onTap: picker.showPicker,
          );
        },
      ),
    );
  }
}
