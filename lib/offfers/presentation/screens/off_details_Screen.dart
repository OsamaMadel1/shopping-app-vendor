import 'package:app_vendor/offfers/application/providers/off_notifier_provider.dart';
import 'package:app_vendor/offfers/domain/entity/off_entity.dart';
import 'package:app_vendor/offfers/presentation/screens/edit_off_screen.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class OffDetailsScreen extends ConsumerWidget {
  final OffEntity off;

  const OffDetailsScreen({super.key, required this.off});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(offNotifierProvider.notifier);
    final originalPrice = off.newPrice / (1 - (off.discountPercentage / 100));
    final hasValidImage = off.image != null && off.image!.isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: Text('Details Offer'.i18n)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // صورة العرض
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: hasValidImage
                    ? Image.network(
                        off.image!,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/placeholder.png',
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const Gap(10),

            Text(
              '${'Name Offer'.i18n}: ${off.name}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const Gap(10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    '${originalPrice.toStringAsFixed(2)}\$',
                    style: const TextStyle(
                      fontSize: 16,
                      decoration: TextDecoration.lineThrough,
                      color: Colors.red,
                      decorationColor: Colors.red,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '${off.newPrice}\$',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${'Start Date'.i18n}: ${DateFormat.yMMMd().format(off.startDate)}',
                ),
                Text(
                  '${'End Date'.i18n}: ${DateFormat.yMMMd().format(off.endDate)}',
                ),
              ],
            ),
            const Gap(10),
            Center(
              child: Expanded(
                child: Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      off.description.isNotEmpty
                          ? off.description.i18n
                          : 'not description'.i18n,
                      style: const TextStyle(
                        fontSize: 16,
                        // color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Gap(10),
            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.edit),
                  label: Text('Update'.i18n),
                  onPressed: () {
                    try {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditOffScreen(
                            off: off,
                            initialImage:
                                // hasValidImage
                                //     ? XFile(off.image!)
                                //     :
                                null,
                          ),
                        ),
                      );
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('حدث خطأ في تحميل الصورة'.i18n)),
                      );
                    }
                  },
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.delete),
                  label: Text('Delete'.i18n),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text('تأكيد الحذف'.i18n),
                        content: Text('هل أنت متأكد من حذف هذا العرض؟'.i18n),
                        actions: [
                          TextButton(
                            child: Text('Cancel'.i18n),
                            onPressed: () => Navigator.pop(context),
                          ),
                          TextButton(
                            child: Text('Delete'.i18n),
                            onPressed: () async {
                              Navigator.pop(context); // إغلاق التنبيه

                              if (off.id == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'لا يمكن حذف عرض بدون معرف'.i18n,
                                    ),
                                  ),
                                );
                                return;
                              }

                              await notifier.deleteOff(
                                off.id!,
                                shopId: off.shopId,
                              );

                              if (context.mounted) {
                                Navigator.pop(context); // الرجوع للخلف
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('تم حذف العرض بنجاح'.i18n),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
