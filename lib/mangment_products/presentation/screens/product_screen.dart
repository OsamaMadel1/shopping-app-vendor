import 'package:app_vendor/authentication/application/providers/auth_notifier_provider.dart';
import 'package:app_vendor/category/application/providers/category_notifier_provider.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_hero/local_hero.dart';
import 'package:go_router/go_router.dart';
import 'package:app_vendor/category/presentation/widgets/category_select_dialog.dart';
import 'package:app_vendor/mangment_products/application/providers/product_notifier_provider.dart';
import 'package:app_vendor/mangment_products/application/product_state.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key});

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  // bool _isGrid = true;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(productNotifierProvider.notifier)
          .fetchProducts(shopId: ref.read(authNotifierProvider).shopId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final productState = ref.watch(productNotifierProvider);

    ref.listen<ProductState>(productNotifierProvider, (previous, next) {
      if (next is ProductError) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.message)));
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('product Screen'.i18n),
        // backgroundColor: Colors.amber.shade300,
        actions: [
          // IconButton(
          //   icon: Icon(_isGrid ? Icons.grid_view : Icons.view_list),
          //   onPressed: () {
          //     setState(() => _isGrid = !_isGrid);
          //   },
          // ),
          IconButton(
            icon: const Icon(Icons.filter_alt),
            tooltip: "filter by category".i18n,
            onPressed: () async {
              final selectedCategoryId = await showDialog<String?>(
                context: context,
                builder: (_) => const CategorySelectDialog(),
              );

              if (selectedCategoryId != null && selectedCategoryId.isNotEmpty) {
                final state = ref.read(categoryNotifierProvider);
                final selectedCategory = state.categories.firstWhere(
                  (cat) => cat.id == selectedCategoryId,
                  // orElse: () => null,
                );

                //  if (selectedCategory  != null) {
                final shopId = ref.read(authNotifierProvider).shopId;
                final categoryName = selectedCategory.name; // نأخذ الاسم

                ref
                    .read(productNotifierProvider.notifier)
                    .fetchProducts(shopId: shopId, categoryName: categoryName);
                // }
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _buildBody(productState)),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              child: Text("add product".i18n),
              onPressed: () {
                context.push('/addProductScreen');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(ProductState state) {
    if (state is ProductInitial || state is ProductLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ProductLoaded) {
      if (state.products.isEmpty) {
        return Center(child: Text('not products'.i18n));
      }

      final products = state.products;

      return LocalHeroScope(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(scale: animation, child: child),
              );
            },
            child:
                //  _isGrid ?
                GridView.builder(
                  key: const ValueKey('gridView'),
                  itemCount: products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.6,
                  ),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return _buildProductCard(product, 'product_$index');
                  },
                ),
            // : ListView.builder(
            //     key: const ValueKey('listView'),
            //     itemCount: products.length,
            //     itemBuilder: (context, index) {
            //       final product = products[index];
            //       return _buildProductCard(
            //         product,
            //         'product_${_isGrid ? 'grid' : 'list'}_$index',
            //       );
            //     },
            //   ),
          ),
        ),
      );
    } else if (state is ProductError) {
      return Center(child: Text('خطأ: ${state.message}'));
    } else {
      return const SizedBox.shrink();
    }
  }

  // Widget _buildProductCard(product, String heroTag) {
  //   return LocalHero(
  //     tag: heroTag,
  //     child: SizedBox(
  //       height: _isGrid ? 280 : 140,
  //       child: InkWell(
  //         borderRadius: BorderRadius.circular(15),
  //         onTap: () {
  //           context.pushNamed(
  //             'productDetailsScreen',
  //             pathParameters: {'id': product.id!},
  //           );
  //         },
  //         child: Card(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(15),
  //           ),
  //           elevation: 4,
  //           color: Colors.white,
  //           shadowColor: Colors.grey.shade300,
  //           child: _isGrid
  //               ? Column(
  //                   crossAxisAlignment: CrossAxisAlignment.stretch,
  //                   children: [
  //                     Expanded(
  //                       child: ClipRRect(
  //                         borderRadius: const BorderRadius.vertical(
  //                           top: Radius.circular(15),
  //                         ),
  //                         child: Image.network(
  //                           product.image,
  //                           fit: BoxFit.cover,
  //                           errorBuilder: (_, __, ___) =>
  //                               const Icon(Icons.image_not_supported),
  //                         ),
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.all(8.0),
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Text(
  //                             product.name,
  //                             style: const TextStyle(
  //                               fontWeight: FontWeight.bold,
  //                               fontSize: 16,
  //                             ),
  //                             maxLines: 1,
  //                             overflow: TextOverflow.ellipsis,
  //                           ),
  //                           const SizedBox(height: 8),
  //                           Text(
  //                             product.description ?? '',
  //                             maxLines: 2,
  //                             overflow: TextOverflow.ellipsis,
  //                             style: const TextStyle(
  //                               fontSize: 13,
  //                               color: Colors.black54,
  //                             ),
  //                           ),
  //                           const SizedBox(height: 6),
  //                           Text(
  //                             'price: ${product.price}${product.currency}',
  //                             style: const TextStyle(
  //                               color: Colors.blue,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 )
  //               : Row(
  //                   children: [
  //                     ClipRRect(
  //                       borderRadius: const BorderRadius.horizontal(
  //                         left: Radius.circular(15),
  //                       ),
  //                       child: Image.network(
  //                         product.image,
  //                         height: double.infinity,
  //                         width: 120,
  //                         fit: BoxFit.cover,
  //                         errorBuilder: (_, __, ___) =>
  //                             const Icon(Icons.image_not_supported),
  //                       ),
  //                     ),
  //                     const Gap(12),
  //                     Expanded(
  //                       child: Padding(
  //                         padding: const EdgeInsets.symmetric(
  //                           vertical: 12.0,
  //                           horizontal: 8,
  //                         ),
  //                         child: Column(
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             Text(
  //                               product.name,
  //                               style: const TextStyle(
  //                                 fontWeight: FontWeight.bold,
  //                                 fontSize: 16,
  //                               ),
  //                               maxLines: 1,
  //                               overflow: TextOverflow.ellipsis,
  //                             ),
  //                             const SizedBox(height: 4),
  //                             Text(
  //                               product.description ?? '',
  //                               maxLines: 2,
  //                               overflow: TextOverflow.ellipsis,
  //                               style: const TextStyle(
  //                                 fontSize: 13,
  //                                 color: Colors.black54,
  //                               ),
  //                             ),
  //                             const SizedBox(height: 6),
  //                             Text(
  //                               'price: ${product.price}${product.currency}',
  //                               style: const TextStyle(
  //                                 color: Colors.teal,
  //                                 fontWeight: FontWeight.bold,
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildProductCard(product, String heroTag) {
    return LocalHero(
      tag: heroTag,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          context.pushNamed(
            'productDetailsScreen',
            pathParameters: {'id': product.id!},
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          // color: Colors.white,
          // shadowColor: Colors.grey.shade300,
          child: Column(
            children: [
              // المحتوى الحالي سواء Grid أو List:
              Expanded(
                child:
                    // _isGrid?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          flex: 5,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15),
                            ),
                            child: Image.network(
                              product.image,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.image_not_supported),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 8),
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  product.description ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    // color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '${'Price'.i18n}: ${product.price}${product.currency == 'USD' ? '\$' : 'E'}',
                                  style: const TextStyle(
                                    // color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                // : Row(
                //     children: [
                //       ClipRRect(
                //         borderRadius: const BorderRadius.horizontal(
                //           left: Radius.circular(15),
                //         ),
                //         child: Image.network(
                //           product.image,
                //           height: double.infinity,
                //           width: 120,
                //           fit: BoxFit.cover,
                //           errorBuilder: (_, __, ___) =>
                //               const Icon(Icons.image_not_supported),
                //         ),
                //       ),
                //       const Gap(12),
                //       Expanded(
                //         child: Padding(
                //           padding: const EdgeInsets.symmetric(
                //             vertical: 12.0,
                //             horizontal: 8,
                //           ),
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Text(
                //                 product.name,
                //                 style: const TextStyle(
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: 16,
                //                 ),
                //                 maxLines: 1,
                //                 overflow: TextOverflow.ellipsis,
                //               ),
                //               const SizedBox(height: 4),
                //               Text(
                //                 product.description ?? '',
                //                 maxLines: 2,
                //                 overflow: TextOverflow.ellipsis,
                //                 style: const TextStyle(
                //                   fontSize: 13,
                //                   color: Colors.black54,
                //                 ),
                //               ),
                //               const SizedBox(height: 6),
                //               Text(
                //                 'price: ${product.price}${product.currency}',
                //                 style: const TextStyle(
                //                   color: Colors.teal,
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
              ),

              // شريط الأزرار في الأسفل
              Container(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey.shade300)),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
                  // color: Colors.grey.shade100,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // زر التعليقات
                    TextButton.icon(
                      onPressed: () {
                        // التنقل إلى صفحة التعليقات وتمرير id المنتج

                        context.pushNamed(
                          'commentsScreen',
                          pathParameters: {'productId': product.id!},
                        );
                        // print('product id: ${product.id}');
                      },
                      icon: const Icon(Icons.comment, size: 18),
                      label: const Text(''),
                    ),

                    // زر اللايك (مثال فقط، يمكنك تعديل المنطق حسب الحاجة)
                    TextButton.icon(
                      onPressed: () {
                        // هنا يمكنك إضافة منطق اللايك، مثل تحديث حالة اللايك
                        // ScaffoldMessenger.of(
                        //   context,
                        // ).showSnackBar(SnackBar(content: Text('Liked!')));
                      },
                      icon: const Icon(Icons.thumb_up, size: 18),
                      label: const Text(''),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
