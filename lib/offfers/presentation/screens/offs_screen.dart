import 'package:app_vendor/authentication/application/providers/auth_notifier_provider.dart';
import 'package:app_vendor/offfers/application/off_state.dart';
import 'package:app_vendor/offfers/application/providers/off_notifier_provider.dart';
import 'package:app_vendor/offfers/presentation/screens/add_off_screen.dart';
import 'package:app_vendor/offfers/presentation/screens/off_details_Screen.dart';
import 'package:app_vendor/offfers/presentation/screens/selectProductForOffScreen.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class OffsScreen extends ConsumerStatefulWidget {
  const OffsScreen({super.key});

  @override
  ConsumerState<OffsScreen> createState() => _OffsScreenState();
}

class _OffsScreenState extends ConsumerState<OffsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final shopId = ref.read(authNotifierProvider).shopId;
      // هنا ضع معرف المتجر الحقيقي بدل "yourShopId"
      ref.read(offNotifierProvider.notifier).loadOffs(shopId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final offsState = ref.watch(offNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Offers'.i18n)),
      body: offsState.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: () => const Center(child: CircularProgressIndicator()),
        loaded: (offers) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: GridView.builder(
                  itemCount: offers.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // عدد الأعمدة
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.7, // لتحديد شكل الكارد
                  ),
                  itemBuilder: (context, index) {
                    final off = offers[index];

                    final newPrice = off.newPrice;
                    final originalPrice =
                        (newPrice / (1 - (off.discountPercentage / 100)));
                    // print('Offer Image URL: ${off.image}');

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => OffDetailsScreen(off: off),
                          ),
                        );
                      },

                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // الصورة
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: off.image != null && off.image!.isNotEmpty
                                  ? Image.network(
                                      off.image!,
                                      height: 120,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : Container(
                                      height: 120,
                                      width: double.infinity,
                                      color: Colors.grey[200],
                                      child: const Icon(Icons.image, size: 40),
                                    ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    off.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const Gap(6),
                                  Text(
                                    off.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 13),
                                  ),
                                  const Gap(10),
                                  // السعر القديم والجديد
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${originalPrice.toStringAsFixed(2)}\$',
                                        style: const TextStyle(
                                          color: Colors.red,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationColor: Colors.red,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        '${newPrice.toStringAsFixed(2)} \$',
                                        style: const TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const Gap(10),

                                  // نهاية العرض
                                  Center(
                                    child: Text(
                                      '${'End In'.i18n}: ${DateFormat.yMMMMd().format(off.endDate)}'
                                          .i18n,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                child: Text('Add Offer'.i18n),
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SelectProductForOffScreen(),
                    ),
                  );

                  if (result != null && result is Map<String, dynamic>) {
                    final selectedProduct = result['product'];
                    final initialImage = result['image'];

                    // بعد الرجوع من شاشة الإضافة أو التعديل
                    final added = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddOffScreen(
                          product: selectedProduct,
                          initialImage: initialImage,
                        ),
                      ),
                    );

                    if (added == true) {
                      final shopId = ref.read(authNotifierProvider).shopId;
                      // إعادة تحميل العروض بعد الإضافة أو التعديل
                      ref.read(offNotifierProvider.notifier).loadOffs(shopId!);
                    }
                  }
                },
              ),
            ],
          ),
        ),
        error: (e) => Center(child: Text(e)),
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     final result = await Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (_) => const SelectProductForOffScreen(),
      //       ),
      //     );

      //     if (result != null && result is Map<String, dynamic>) {
      //       final selectedProduct = result['product'];
      //       final initialImage = result['image'];

      //       // بعد الرجوع من شاشة الإضافة أو التعديل
      //       final added = await Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (_) => AddOffScreen(
      //             product: selectedProduct,
      //             initialImage: initialImage,
      //           ),
      //         ),
      //       );

      //       if (added == true) {
      //         final shopId = ref.read(authNotifierProvider).shopId;
      //         // إعادة تحميل العروض بعد الإضافة أو التعديل
      //         ref.read(offNotifierProvider.notifier).loadOffs(shopId!);
      //       }
      //     }
      //   },
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
