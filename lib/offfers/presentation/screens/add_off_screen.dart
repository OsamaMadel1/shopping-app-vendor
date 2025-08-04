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

    final form = ref.read(addOffFormProvider);

    // ✅ تعيين السعر القديم مباشرة في النموذج
    form
        .control('oldPrice')
        .updateValue(widget.product.price, emitEvent: false);

    final discountControl = form.control('discountPercentage');
    final newPriceControl = form.control('newPrice');

    // ✅ حساب السعر الجديد تلقائيًا عند تغيير الخصم
    discountControl.valueChanges.listen((value) {
      final oldPrice = form.control('oldPrice').value;
      if (value is num && oldPrice != null) {
        final discount = value.clamp(0, 100);
        final calculatedNewPrice = oldPrice - (oldPrice * discount / 100);
        newPriceControl.updateValue(
          double.parse(calculatedNewPrice.toStringAsFixed(2)),
        );
      }
    });
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
      appBar: AppBar(
        title: Text('Add Offer'.i18n),
        centerTitle: true,
        elevation: 1,
      ),
      body: ReactiveForm(
        formGroup: form,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Offer Image'.i18n,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const Gap(8),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey.shade300),
                    color: Colors.grey[100],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
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
                              Icon(
                                Icons.image_outlined,
                                size: 50,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Tap to select image'.i18n,
                                style: TextStyle(
                                  fontSize: 16,
                                  // color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),

              const Gap(24),

              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      ReactiveTextInputWidget(
                        prefixIcon: Icons.title,
                        hint: 'Offer Name'.i18n,
                        controllerName: 'nameOffer',
                        // color: Colors.black87,
                      ),
                      const Gap(12),
                      ReactiveTextInputWidget(
                        prefixIcon: Icons.description,
                        hint: 'Description'.i18n,
                        controllerName: 'descriptionOffer',
                        // color: Colors.black87,
                      ),
                      const Gap(12),
                      ReactiveTextInputWidget(
                        prefixIcon: Icons.price_change,
                        readOnly: true,
                        controllerName: 'oldPrice',
                        hint: 'Old Price',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                      ),
                      const Gap(16),
                      ReactiveTextInputWidget(
                        prefixIcon: Icons.percent,
                        hint: 'Discount Percentage'.i18n,
                        controllerName: 'discountPercentage',
                        keyboardType: TextInputType.number,
                      ),
                      const Gap(12),
                      ReactiveTextInputWidget(
                        prefixIcon: Icons.price_change,
                        controllerName: 'newPrice',
                        hint: 'New Price'.i18n,
                        readOnly: true,
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                      ),
                      const Gap(16),

                      Row(
                        children: [
                          Expanded(
                            child: _buildDatePicker(
                              'startDate'.i18n,
                              'Start Date'.i18n,
                            ),
                          ),
                          const Gap(12),
                          Expanded(
                            child: _buildDatePicker(
                              'endDate'.i18n,
                              'End Date'.i18n,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              isSaving
                  ? const Center(child: CircularProgressIndicator())
                  : ButtonWidget(
                      text: 'Save Offer'.i18n,
                      width: double.infinity,
                      onTap: () async {
                        if (!form.valid) {
                          form.markAllAsTouched();
                          return;
                        }

                        if (selectedImage == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please select an image'.i18n),
                            ),
                          );
                          return;
                        }

                        if (widget.product.id == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('حدث خطأ في المنتج'.i18n)),
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('تم إضافة العرض بنجاح'.i18n)),
                        );
                        if (!mounted) return;
                        Navigator.pop(context, true);
                      },
                    ),
            ],
          ),
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
