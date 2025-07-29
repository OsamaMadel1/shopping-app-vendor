import 'dart:io';
import 'package:app_vendor/authentication/application/providers/auth_notifier_provider.dart';
import 'package:app_vendor/mangment_products/application/product_state.dart';
import 'package:app_vendor/mangment_products/application/providers/product_notifier_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class SelectProductForOffScreen extends ConsumerStatefulWidget {
  const SelectProductForOffScreen({super.key});

  @override
  ConsumerState<SelectProductForOffScreen> createState() =>
      _SelectProductForOffScreenState();
}

class _SelectProductForOffScreenState
    extends ConsumerState<SelectProductForOffScreen> {
  @override
  void initState() {
    super.initState();
    // هنا تنفذ تحميل المنتجات مرة واحدة عند بداية الشاشة
    Future.microtask(() {
      // استدعاء fetchProducts من الموفّر (Provider)
      final shopId = ref.read(authNotifierProvider).shopId;
      ref.read(productNotifierProvider.notifier).fetchProducts(shopId: shopId);
    });
  }

  Future<File?> _getNetworkImageAsFile(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final documentDirectory = await getApplicationDocumentsDirectory();
        final fileName = basename(imageUrl);
        final file = File('${documentDirectory.path}/$fileName');
        await file.writeAsBytes(response.bodyBytes);
        return file;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(productNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('اختر منتجًا')),
      body: Builder(
        builder: (context) {
          if (productsState is ProductInitial) {
            return const Center(child: Text('لا توجد منتجات بعد'));
          } else if (productsState is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (productsState is ProductLoaded) {
            final products = productsState.products;
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.75,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];

                return GestureDetector(
                  onTap: () async {
                    final image = await _getNetworkImageAsFile(product.image);
                    final file = image != null ? XFile(image.path) : null;

                    if (!context.mounted) return;
                    Navigator.pop(context, {'product': product, 'image': file});
                  },
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: product.image.isNotEmpty
                              ? Image.network(
                                  product.image,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      const Icon(Icons.broken_image),
                                )
                              : const Icon(Icons.image),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            product.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else if (productsState is ProductError) {
            return Center(child: Text(productsState.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

// import 'dart:io';
// import 'package:app_vendor/authentication/application/providers/auth_notifier_provider.dart';
// import 'package:app_vendor/mangment_products/application/product_state.dart';
// import 'package:app_vendor/mangment_products/application/providers/product_notifier_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart';

// class SelectProductForOffScreen extends ConsumerStatefulWidget {
//   const SelectProductForOffScreen({super.key});

//   @override
//   ConsumerState<SelectProductForOffScreen> createState() =>
//       _SelectProductForOffScreenState();
// }

// class _SelectProductForOffScreenState
//     extends ConsumerState<SelectProductForOffScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Future.microtask(() {
//       final shopId = ref.read(authNotifierProvider).shopId;
//       if (shopId != null) {
//         ref.read(productNotifierProvider.notifier).fetchProducts(shopId: shopId);
//       }
//     });
//   }

//   Future<File?> _downloadImageAsFile(String imageUrl) async {
//     try {
//       final response = await http.get(Uri.parse(imageUrl));
//       if (response.statusCode == 200) {
//         final dir = await getTemporaryDirectory();
//         final filename = basename(imageUrl);
//         final file = File('${dir.path}/$filename');
//         await file.writeAsBytes(response.bodyBytes);
//         return file;
//       }
//     } catch (_) {}
//     return null;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final state = ref.watch(productNotifierProvider);

//     return Scaffold(
//       appBar: AppBar(title: const Text('اختر منتجًا')),
//       body: state.maybeWhen(
//         loading: () => const Center(child: CircularProgressIndicator()),
//         loaded: (products) {
//           if (products.isEmpty) {
//             return const Center(child: Text('لا توجد منتجات متاحة'));
//           }

//           return GridView.builder(
//             padding: const EdgeInsets.all(8),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: 8,
//               crossAxisSpacing: 8,
//               childAspectRatio: 0.75,
//             ),
//             itemCount: products.length,
//             itemBuilder: (context, index) {
//               final product = products[index];

//               return GestureDetector(
//                 onTap: () async {
//                   final file = await _downloadImageAsFile(product.image);
//                   if (!context.mounted) return;

//                   Navigator.pop(context, {
//                     'product': product,
//                     'image': file != null ? XFile(file.path) : null,
//                   });
//                 },
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 3,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Expanded(
//                         child: ClipRRect(
//                           borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//                           child: product.image.isNotEmpty
//                               ? Image.network(
//                                   product.image,
//                                   fit: BoxFit.cover,
//                                   errorBuilder: (_, __, ___) =>
//                                       const Icon(Icons.broken_image),
//                                 )
//                               : Container(
//                                   color: Colors.grey[300],
//                                   child: const Icon(Icons.image_not_supported),
//                                 ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           product.name,
//                           textAlign: TextAlign.center,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14,
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//         error: (message) => Center(child: Text(message)),
//         orElse: () => const SizedBox.shrink(),
//       ),
//     );
//   }
// }
