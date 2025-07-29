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

//     // تعبئة النموذج بالقيم المبدئية
//     final form = ref.read(addOffFormProvider);
//     form.control('nameOffer').value = widget.off.name;
//     form.control('descriptionOffer').value = widget.off.description;
//     form.control('discountPercentage').value = widget.off.discountPercentage;
//     form.control('newPrice').value = widget.off.newPrice;
//     form.control('startDate').value = widget.off.startDate;
//     form.control('endDate').value = widget.off.endDate;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final form = ref.watch(addOffFormProvider);
//     final notifier = ref.read(offNotifierProvider.notifier);

//     return Scaffold(
//       appBar: AppBar(title: Center(child: const Text('تعديل العرض'))),
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
//                       : Image.network(
//                           widget.off.image ?? '',
//                           fit: BoxFit.cover,
//                         ),
//                 ),
//               ),
//             ),
//             const Gap(12),

//             // الحقول
//             ReactiveTextInputWidget(
//               prefixIcon: Icons.title,
//               hint: 'Name Offer'.i18n,
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
//               prefixIcon: Icons.percent,
//               hint: 'Discount Percentage'.i18n,
//               controllerName: 'discountPercentage',
//               color: Colors.black87,
//             ),
//             const Gap(12),
//             ReactiveTextInputWidget(
//               prefixIcon: Icons.price_change,
//               hint: 'New Price'.i18n,
//               controllerName: 'newPrice',
//               color: Colors.black87,
//             ),
//             const Gap(12),

//             // التواريخ
//             Row(
//               children: [
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     child: ReactiveDatePicker<DateTime>(
//                       formControlName: 'startDate',
//                       firstDate: DateTime(2020),
//                       lastDate: DateTime(2100),
//                       builder: (context, picker, _) => ListTile(
//                         title: Center(child: Text('Start Date'.i18n)),
//                         subtitle: picker.value == null
//                             ? Center(child: Text('Choose a Date '.i18n))
//                             : Center(
//                                 child: Text(
//                                   DateFormat.yMd().format(picker.value!),
//                                 ),
//                               ),
//                         onTap: picker.showPicker,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const Gap(12),
//                 Expanded(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey),
//                       borderRadius: BorderRadius.circular(25),
//                     ),
//                     child: ReactiveDatePicker<DateTime>(
//                       formControlName: 'endDate',
//                       firstDate: DateTime(2020),
//                       lastDate: DateTime(2100),
//                       builder: (context, picker, _) => ListTile(
//                         title: Center(child: Text('End Date'.i18n)),
//                         subtitle: picker.value == null
//                             ? Center(child: Text('Choose a Date '.i18n))
//                             : Center(
//                                 child: Text(
//                                   DateFormat.yMd().format(picker.value!),
//                                 ),
//                               ),
//                         onTap: picker.showPicker,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),

//             const Gap(20),
//             ButtonWidget(
//               text: 'تحديث العرض',
//               onTap: () async {
//                 if (form.valid) {
//                   final updatedOff= OffEntity(
//                     name: form.control('nameOffer').value,
//                     description: form.control('descriptionOffer').value,
//                     discountPercentage: form
//                         .control('discountPercentage')
//                         .value,
//                     newPrice: form.control('newPrice').value,
//                     startDate: form.control('startDate').value,
//                     endDate: form.control('endDate').value,
//                     image: selectedImage?.path,
//                     id: widget
//                         .off
//                         .id, // مهم: إذا لديك معرف العرض، ضعه هنا للحفاظ عليه
//                     shopId: widget.off.shopId, // لا تنسى تمرير shopId الأصلي
//                     productId: widget.off.productId, // كذلك productId الأصلي
//                   );

//                   await notifier.updateOff(updatedOff);
//                   Navigator.pop(
//                     context,
//                     true,
//                   ); // يُعيد القيمة لإعادة التحميل مثلاً
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
// }

double? calculateOldPrice(double? newPrice, double? discountPercentage) {
  if (newPrice == null ||
      discountPercentage == null ||
      discountPercentage == 0) {
    return null;
  }
  return newPrice / (1 - (discountPercentage / 100));
}

void _updateOldPrice(FormGroup form) {
  final newPrice = form.control('newPrice').value;
  final discount = form.control('discountPercentage').value;
  final calculated = calculateOldPrice(newPrice, discount);

  form.control('oldPrice').value = calculated;
}

class EditOffScreen extends ConsumerStatefulWidget {
  final OffEntity off;
  final XFile? initialImage;

  const EditOffScreen({super.key, required this.off, this.initialImage});

  @override
  ConsumerState<EditOffScreen> createState() => _EditOffScreenState();
}

class _EditOffScreenState extends ConsumerState<EditOffScreen> {
  late XFile? selectedImage;

  @override
  void initState() {
    super.initState();
    selectedImage = widget.initialImage;

    final form = ref.read(editOffFormProvider(widget.off));

    // حساب السعر القديم بمجرد تحميل الشاشة
    final oldPrice = calculateOldPrice(
      widget.off.newPrice,
      widget.off.discountPercentage,
    );
    form.control('oldPrice').value = oldPrice;

    // مراقبة التغيير وحساب تلقائي عند تعديل الخصم أو السعر الجديد
    form.control('discountPercentage').valueChanges.listen((_) {
      _updateOldPrice(form);
    });
    form.control('newPrice').valueChanges.listen((_) {
      _updateOldPrice(form);
    });
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(editOffFormProvider(widget.off));
    final notifier = ref.read(offNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('تعديل العرض')),
      body: ReactiveForm(
        formGroup: form,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // صورة العرض
            GestureDetector(
              onTap: () async {
                final picked = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (picked != null) {
                  setState(() {
                    selectedImage = picked;
                  });
                }
              },
              child: Container(
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  color: Colors.grey[100],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: selectedImage != null
                      ? Image.file(
                          File(selectedImage!.path),
                          width: double.infinity,
                          height: 160,
                          fit: BoxFit.cover,
                        )
                      : (widget.off.image != null &&
                            widget.off.image!.isNotEmpty)
                      ? Image.network(
                          widget.off.image!,
                          width: double.infinity,
                          height: 160,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/images/placeholder.png',
                          width: double.infinity,
                          height: 160,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            const Gap(12),

            ReactiveTextInputWidget(
              prefixIcon: Icons.title,
              hint: 'Name Offer'.i18n,
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
              prefixIcon: Icons.history,
              hint: 'Old Price'.i18n,
              controllerName: 'oldPrice',
              readOnly: true, // السعر القديم لا يمكن تعديله
              color: Colors.black87,
            ),
            ReactiveTextField<double>(
              formControlName: 'oldPrice',
              readOnly: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.history),
                labelText: 'Old Price'.i18n,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
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
              hint: 'New Price'.i18n,
              controllerName: 'newPrice',
              color: Colors.black87,
            ),
            const Gap(12),

            // التواريخ
            Row(
              children: [
                Expanded(child: _datePicker('startDate', 'Start Date'.i18n)),
                const Gap(12),
                Expanded(child: _datePicker('endDate', 'End Date'.i18n)),
              ],
            ),
            const Gap(20),

            ButtonWidget(
              text: 'تحديث العرض',
              onTap: () async {
                if (form.valid) {
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
                  try {
                    await notifier.updateOff(updatedOff);
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم التحديث بنجاح')),
                    );
                    Navigator.pop(context, true);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('فشل في التحديث: $e')),
                    );
                  }
                } else {
                  form.markAllAsTouched();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('يرجى تعبئة جميع الحقول المطلوبة'),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _datePicker(String controlName, String title) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(25),
      ),
      child: ReactiveDatePicker<DateTime>(
        formControlName: controlName,
        firstDate: DateTime(2020),
        lastDate: DateTime(2100),
        builder: (context, picker, _) => ListTile(
          title: Center(child: Text(title)),
          subtitle: picker.value == null
              ? Center(child: Text('Choose a Date'.i18n))
              : Center(child: Text(DateFormat.yMd().format(picker.value!))),
          onTap: picker.showPicker,
        ),
      ),
    );
  }
}
