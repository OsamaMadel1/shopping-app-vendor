// import 'package:app_vendor/offer/application/offer_state.dart';
// import 'package:app_vendor/offer/application/providers/offer_notifier_provider.dart';
// import 'package:app_vendor/offer/presentation/screens/add_offer_screen.dart';
// import 'package:app_vendor/offer/presentation/screens/selectProductForOfferScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class OffersScreen extends ConsumerWidget {
//   const OffersScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final offersState = ref.watch(offerNotifierProvider);

//     return Scaffold(
//       appBar: AppBar(title: const Text('العروض')),
//       body: Column(
//         children: [
//           Expanded(
//             child: offersState.when(
//               initial: () => const Center(child: Text('لا توجد عروض بعد')),
//               loading: () => const Center(child: CircularProgressIndicator()),
//               loaded: (offers) => ListView.builder(
//                 itemCount: offers.length,
//                 itemBuilder: (context, index) {
//                   final offer = offers[index];
//                   return ListTile(
//                     title: Text(offer.name),
//                     subtitle: Text('خصم: ${offer.discountPercentage}%'),
//                     leading: offer.imagePath != null
//                         ? Image.network(offer.imagePath!)
//                         : const Icon(Icons.local_offer),
//                   );
//                 },
//               ),
//               error: (e) => Center(child: Text(e)),
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final result = await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => const SelectProductForOfferScreen(),
//             ),
//           );

//           if (result != null && result is Map<String, dynamic>) {
//             final selectedProduct = result['product'];
//             final initialImage = result['image'];

//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => AddOfferScreen(
//                   product: selectedProduct,
//                   initialImage: initialImage,
//                 ),
//               ),
//             );
//           }
//         },
//         child: const Icon(Icons.add),
//       ),
//       floatingActionButtonLocation:
//           FloatingActionButtonLocation.miniCenterDocked,
//     );
//   }
// }

// class OffersScreen extends ConsumerWidget {
//   const OffersScreen({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final offersState = ref.watch(offerNotifierProvider);

//     return Scaffold(
//       appBar: AppBar(title: Text('Offers'.i18n)),
//       body: offersState.when(
//         initial: () => Center(child: Text('Not Offers'.i18n)),
//         loading: () => const Center(child: CircularProgressIndicator()),
//         loaded: (offers) => Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: GridView.builder(
//             itemCount: offers.length,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2, // عدد الأعمدة
//               crossAxisSpacing: 8,
//               mainAxisSpacing: 8,
//               childAspectRatio: 0.7, // لتحديد شكل الكارد
//             ),
//             itemBuilder: (context, index) {
//               final offer = offers[index];

//               final newPrice = offer.newPrice;
//               final originalPrice =
//                   (newPrice / (1 - (offer.discountPercentage / 100)));

//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => OfferDetailsScreen(offer: offer),
//                     ),
//                   );
//                 },

//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 4,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // الصورة
//                       ClipRRect(
//                         borderRadius: const BorderRadius.vertical(
//                           top: Radius.circular(12),
//                         ),
//                         child: offer.imagePath != null
//                             ? Image.network(
//                                 offer.imagePath!,
//                                 height: 120,
//                                 width: double.infinity,
//                                 fit: BoxFit.cover,
//                               )
//                             : Container(
//                                 height: 120,
//                                 width: double.infinity,
//                                 color: Colors.grey[200],
//                                 child: const Icon(Icons.image, size: 40),
//                               ),
//                       ),

//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               offer.name,
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             const SizedBox(height: 4),

//                             // السعر القديم والجديد
//                             Text(
//                               ' ${'Original Price'.i18n} : ${originalPrice.toStringAsFixed(2)} \$',
//                               style: const TextStyle(
//                                 decoration: TextDecoration.lineThrough,
//                                 color: Colors.grey,
//                                 fontSize: 12,
//                               ),
//                             ),
//                             Text(
//                               '${'New Price'.i18n} : ${newPrice.toStringAsFixed(2)} \$',
//                               style: const TextStyle(
//                                 color: Colors.green,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 14,
//                               ),
//                             ),

//                             const SizedBox(height: 4),

//                             // نهاية العرض
//                             Text(
//                               '${'End in'.i18n}: ${DateFormat.yMd().format(offer.endDate)}'
//                                   .i18n,
//                               style: const TextStyle(
//                                 fontSize: 12,
//                                 color: Colors.black54,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//         error: (e) => Center(child: Text(e)),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final result = await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => const SelectProductForOfferScreen(),
//             ),
//           );

//           if (result != null && result is Map<String, dynamic>) {
//             final selectedProduct = result['product'];
//             final initialImage = result['image'];

//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => AddOfferScreen(
//                   product: selectedProduct,
//                   initialImage: initialImage,
//                 ),
//               ),
//             );
//           }
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:app_vendor/authentication/application/providers/auth_notifier_provider.dart';
import 'package:app_vendor/offfers/application/off_state.dart';
import 'package:app_vendor/offfers/application/providers/off_notifier_provider.dart';
import 'package:app_vendor/offfers/presentation/screens/add_off_screen.dart';
import 'package:app_vendor/offfers/presentation/screens/off_details_Screen.dart';
import 'package:app_vendor/offfers/presentation/screens/selectProductForOffScreen.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    final shopId = ref.read(authNotifierProvider).shopId;
    // هنا ضع معرف المتجر الحقيقي بدل "yourShopId"
    ref.read(offNotifierProvider.notifier).loadOffs(shopId!);
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
              print('Offer Image URL: ${off.image}');

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
                            const SizedBox(height: 4),

                            // السعر القديم والجديد
                            Text(
                              ' ${'Original Price'.i18n} : ${originalPrice.toStringAsFixed(2)} \$',
                              style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              '${'New Price'.i18n} : ${newPrice.toStringAsFixed(2)} \$',
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 4),

                            // نهاية العرض
                            Text(
                              '${'End in'.i18n}: ${DateFormat.yMd().format(off.endDate)}'
                                  .i18n,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
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
        error: (e) => Center(child: Text(e)),
      ),
      floatingActionButton: FloatingActionButton(
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
        child: const Icon(Icons.add),
      ),
    );
  }
}

// class OffCard extends StatelessWidget {
//   final OffEntity off;
//   final VoidCallback onTap;

//   const OffCard({required this.off, required this.onTap, super.key});

//   @override
//   Widget build(BuildContext context) {
//     final newPrice = off.newPrice;
//     final originalPrice = (newPrice / (1 - (off.discountPercentage / 100)));

//     return GestureDetector(
//       onTap: onTap,
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         elevation: 4,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ClipRRect(
//               borderRadius: const BorderRadius.vertical(
//                 top: Radius.circular(12),
//               ),
//               child: off.image != null && off.image!.isNotEmpty
//                   ? Image.network(
//                       off.image!,
//                       height: 120,
//                       width: double.infinity,
//                       fit: BoxFit.cover,
//                     )
//                   : Container(
//                       height: 120,
//                       width: double.infinity,
//                       color: Colors.grey[200],
//                       child: const Icon(Icons.image, size: 40),
//                     ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     off.name,
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     '${'Original Price'.i18n} : ${originalPrice.toStringAsFixed(2)} \$',
//                     style: const TextStyle(
//                       decoration: TextDecoration.lineThrough,
//                       color: Colors.grey,
//                       fontSize: 12,
//                     ),
//                   ),
//                   Text(
//                     '${'New Price'.i18n} : ${newPrice.toStringAsFixed(2)} \$',
//                     style: const TextStyle(
//                       color: Colors.green,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 14,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     '${'End in'.i18n}: ${DateFormat.yMd().format(off.endDate)}',
//                     style: const TextStyle(fontSize: 12, color: Colors.black54),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
