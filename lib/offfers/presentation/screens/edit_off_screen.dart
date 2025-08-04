import 'dart:io';
import 'package:app_vendor/core/presentation/widgets/button_widget.dart';
import 'package:app_vendor/core/presentation/widgets/reactive_text_input_widget.dart';
import 'package:app_vendor/offfers/application/providers/edit_off_form_provider.dart';
import 'package:app_vendor/offfers/application/providers/off_notifier_provider.dart';
import 'package:app_vendor/offfers/domain/entity/off_entity.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

// class EditOffScreen extends ConsumerStatefulWidget {
//   final OffEntity off;
//   final XFile? initialImage;

//   const EditOffScreen({super.key, required this.off, this.initialImage});

//   @override
//   ConsumerState<EditOffScreen> createState() => _EditOffScreenState();
// }

// class _EditOffScreenState extends ConsumerState<EditOffScreen> {
//   late XFile? selectedImage;

//   @override
//   void initState() {
//     super.initState();
//     selectedImage = widget.initialImage;

//     final form = ref.read(editOffFormProvider(widget.off));

//   }

//   @override
//   Widget build(BuildContext context) {
//     final form = ref.watch(editOffFormProvider(widget.off));
//     final notifier = ref.read(offNotifierProvider.notifier);

//     return Scaffold(
//       appBar: AppBar(title: Text('Update Offer'.i18n)),
//       body: ReactiveForm(
//         formGroup: form,
//         child: ListView(
//           padding: const EdgeInsets.all(16),
//           children: [
//             // صورة العرض
//             GestureDetector(
//               onTap: () async {
//                 final picked = await ImagePicker().pickImage(
//                   source: ImageSource.gallery,
//                 );
//                 if (picked != null) {
//                   setState(() {
//                     selectedImage = picked;
//                   });
//                 }
//               },
//               child: Container(
//                 height: 160,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   border: Border.all(color: Colors.grey.shade300),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.2),
//                       blurRadius: 6,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                   color: Colors.grey[100],
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(16),
//                   child: selectedImage != null
//                       ? Image.file(
//                           File(selectedImage!.path),
//                           width: double.infinity,
//                           height: 160,
//                           fit: BoxFit.cover,
//                         )
//                       : (widget.off.image != null &&
//                             widget.off.image!.isNotEmpty)
//                       ? Image.network(
//                           widget.off.image!,
//                           width: double.infinity,
//                           height: 160,
//                           fit: BoxFit.cover,
//                         )
//                       : Image.asset(
//                           'assets/images/placeholder.png',
//                           width: double.infinity,
//                           height: 160,
//                           fit: BoxFit.cover,
//                         ),
//                 ),
//               ),
//             ),
//             const Gap(12),
//             ReactiveTextInputWidget(
//               prefixIcon: Icons.title,
//               hint: 'Offer Name'.i18n,
//               controllerName: 'nameOffer',
//               color: Colors.black87,
//             ),
//             const Gap(12),
//             ReactiveTextInputWidget(
//               prefixIcon: Icons.description,
//               hint: 'Description'.i18n,
//               controllerName: 'descriptionOffer',
//               color: Colors.black87,
//             ),
//             const Gap(12),
//             ReactiveTextInputWidget(
//               prefixIcon: Icons.history,
//               hint: 'Old Price'.i18n,
//               controllerName: 'oldPrice',
//               readOnly: true, // السعر القديم لا يمكن تعديله
//               // color: Colors.black87,
//             ),
//             const Gap(12),
//             ReactiveTextInputWidget(
//               prefixIcon: Icons.percent,
//               hint: 'Discount Percentage'.i18n,
//               controllerName: 'discountPercentage',
//               // color: Colors.black87,
//             ),
//             const Gap(12),
//             ReactiveTextInputWidget(
//               prefixIcon: Icons.price_change,
//               hint: 'New Price'.i18n,
//               controllerName: 'newPrice',
//               // color: Colors.black87,
//             ),
//             const Gap(12),

//             // التواريخ
//             Row(
//               children: [
//                 Expanded(child: _datePicker('startDate', 'Start Date'.i18n)),
//                 const Gap(12),
//                 Expanded(child: _datePicker('endDate', 'End Date'.i18n)),
//               ],
//             ),
//             const Gap(20),

//             ButtonWidget(
//               text: 'تحديث العرض',
//               onTap: () async {
//                 if (form.valid) {
//                   final updatedOff = OffEntity(
//                     id: widget.off.id,
//                     shopId: widget.off.shopId,
//                     productId: widget.off.productId,
//                     name: form.control('nameOffer').value,
//                     description: form.control('descriptionOffer').value,
//                     discountPercentage: form
//                         .control('discountPercentage')
//                         .value,
//                     newPrice: form.control('newPrice').value,
//                     startDate: form.control('startDate').value,
//                     endDate: form.control('endDate').value,
//                     image: selectedImage?.path ?? widget.off.image,
//                   );
//                   try {
//                     await notifier.updateOff(updatedOff);
//                     if (!mounted) return;
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('تم التحديث بنجاح')),
//                     );
//                     Navigator.pop(context, true);
//                   } catch (e) {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('فشل في التحديث: $e')),
//                     );
//                   }
//                 } else {
//                   form.markAllAsTouched();
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text('يرجى تعبئة جميع الحقول المطلوبة'),
//                     ),
//                   );
//                 }
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _datePicker(String controlName, String title) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey),
//         borderRadius: BorderRadius.circular(25),
//       ),
//       child: ReactiveDatePicker<DateTime>(
//         formControlName: controlName,
//         firstDate: DateTime(2020),
//         lastDate: DateTime(2100),
//         builder: (context, picker, _) => ListTile(
//           title: Center(child: Text(title)),
//           subtitle: picker.value == null
//               ? Center(child: Text('Choose a Date'.i18n))
//               : Center(child: Text(DateFormat.yMd().format(picker.value!))),
//           onTap: picker.showPicker,
//         ),
//       ),
//     );
//   }
// }

class EditOffScreen extends ConsumerStatefulWidget {
  final OffEntity off;
  final XFile? initialImage;

  const EditOffScreen({super.key, required this.off, this.initialImage});

  @override
  ConsumerState<EditOffScreen> createState() => _EditOffScreenState();
}

class _EditOffScreenState extends ConsumerState<EditOffScreen> {
  late XFile? selectedImage;
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    selectedImage = widget.initialImage;

    final form = ref.read(editOffFormProvider(widget.off));

    // السعر القديم ثابت من العرض الحالي
    final oldPrice = calculateOldPrice(
      widget.off.newPrice,
      widget.off.discountPercentage,
    );

    form.control('oldPrice').updateValue(oldPrice, emitEvent: false);
    form.control('nameOffer').updateValue(widget.off.name, emitEvent: false);
    form
        .control('descriptionOffer')
        .updateValue(widget.off.description, emitEvent: false);
    form
        .control('discountPercentage')
        .updateValue(widget.off.discountPercentage, emitEvent: false);
    form.control('newPrice').updateValue(widget.off.newPrice, emitEvent: false);
    form
        .control('startDate')
        .updateValue(widget.off.startDate, emitEvent: false);
    form.control('endDate').updateValue(widget.off.endDate, emitEvent: false);

    // ✅ تحديث السعر الجديد تلقائيًا عند تغيير الخصم
    form.control('discountPercentage').valueChanges.listen((value) {
      final oldPrice = form.control('oldPrice').value;
      if (value is num && oldPrice != null) {
        final discount = value.clamp(0, 100);
        final calculatedNewPrice = oldPrice - (oldPrice * discount / 100);
        form
            .control('newPrice')
            .updateValue(double.parse(calculatedNewPrice.toStringAsFixed(2)));
      }
    });
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => selectedImage = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(editOffFormProvider(widget.off));
    final notifier = ref.read(offNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('تحديث العرض'.i18n),
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
                            fit: BoxFit.cover,
                          )
                        : (widget.off.image != null &&
                              widget.off.image!.isNotEmpty)
                        ? Image.network(widget.off.image!, fit: BoxFit.cover)
                        : Image.asset(
                            'assets/images/placeholder.png',
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              const Gap(24),

              /// باقي النموذج تمامًا مثل AddOffScreen:
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
                      ),
                      const Gap(12),
                      ReactiveTextInputWidget(
                        prefixIcon: Icons.description,
                        hint: 'Description'.i18n,
                        controllerName: 'descriptionOffer',
                      ),
                      const Gap(12),
                      ReactiveTextInputWidget(
                        prefixIcon: Icons.price_change,
                        readOnly: true,
                        controllerName: 'oldPrice',
                        hint: 'Old Price',
                        keyboardType: TextInputType.number,
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
                      ),
                      const Gap(16),
                      Row(
                        children: [
                          Expanded(
                            child: _buildDatePicker(
                              'startDate',
                              'Start Date'.i18n,
                            ),
                          ),
                          const Gap(12),
                          Expanded(
                            child: _buildDatePicker('endDate', 'End Date'.i18n),
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
                      text: 'Update Offer'.i18n,
                      width: double.infinity,
                      onTap: () async {
                        if (!form.valid) {
                          form.markAllAsTouched();
                          return;
                        }

                        setState(() => isSaving = true);

                        final updatedOff = OffEntity(
                          id: widget.off.id,
                          shopId: widget.off.shopId,
                          productId: widget.off.productId,
                          name: form.control('nameOffer').value,
                          description: form.control('descriptionOffer').value,
                          discountPercentage: form
                              .control('discountPercentage')
                              .value,
                          newPrice: form.control('newPrice').value,
                          startDate: form.control('startDate').value,
                          endDate: form.control('endDate').value,
                          image: selectedImage?.path ?? widget.off.image,
                        );

                        await notifier.updateOff(updatedOff);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('تم تعديل العرض بنجاح'.i18n)),
                        );
                        if (context.mounted) Navigator.pop(context, true);
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
            title: Center(child: Text(label)),
            subtitle: picker.value == null
                ? Center(child: Text('Choose a date'.i18n))
                : Center(child: Text(DateFormat.yMd().format(picker.value!))),
            onTap: picker.showPicker,
          );
        },
      ),
    );
  }

  double calculateOldPrice(double newPrice, double discountPercentage) {
    return newPrice / (1 - discountPercentage / 100);
  }
}
