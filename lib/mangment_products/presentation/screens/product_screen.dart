import 'package:app_vendor/authentication/application/providers/auth_notifier_provider.dart';
import 'package:app_vendor/category/application/providers/category_notifier_provider.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_hero/local_hero.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:app_vendor/core/presentation/widgets/button_widget.dart';
import 'package:app_vendor/category/presentation/widgets/category_select_dialog.dart';
import 'package:app_vendor/mangment_products/application/providers/product_notifier_provider.dart';
import 'package:app_vendor/mangment_products/application/product_state.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key});

  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  bool _isGrid = true;

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
        backgroundColor: Colors.amber.shade300,
        actions: [
          IconButton(
            icon: Icon(_isGrid ? Icons.grid_view : Icons.view_list),
            onPressed: () {
              setState(() => _isGrid = !_isGrid);
            },
          ),
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
            child: ButtonWidget(
              text: "add product".i18n,
              onTap: () {
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
            child: _isGrid
                ? GridView.builder(
                    key: const ValueKey('gridView'),
                    itemCount: products.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return _buildProductCard(product, 'product_$index');
                    },
                  )
                : ListView.builder(
                    key: const ValueKey('listView'),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return _buildProductCard(
                        product,
                        'product_${_isGrid ? 'grid' : 'list'}_$index',
                      );
                    },
                  ),
          ),
        ),
      );
    } else if (state is ProductError) {
      return Center(child: Text('خطأ: ${state.message}'));
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildProductCard(product, String heroTag) {
    return LocalHero(
      tag: heroTag,
      child: SizedBox(
        height: _isGrid
            ? 280
            : 150, // Slightly increased height for better spacing
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
            child: _isGrid
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Image Section
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Center(
                            child: Container(
                              color: Colors.grey.shade100,
                              child: Image.network(
                                product.image,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                alignment: Alignment
                                    .center, // Changed to contain for better image display
                                loadingBuilder: (_, child, progress) {
                                  return progress == null
                                      ? child
                                      : const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                },
                                errorBuilder: (_, __, ___) => const Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Text Content Section
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Product Name (single line)
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            // Product Description (max two lines)
                            if (product.description != null)
                              Text(
                                product.description,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            const SizedBox(height: 6),
                            // Price (single line)
                            Text(
                              '${product.price} ${product.currency}',
                              style: const TextStyle(
                                color: Colors.teal,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Row(
                    children: [
                      // Image Section
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(12),
                          ),
                          color: Colors.grey[100], // Fallback background
                        ),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(12),
                          ),
                          child: Image.network(
                            product.image,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (_, child, progress) {
                              return progress == null
                                  ? child
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    );
                            },
                            errorBuilder: (_, __, ___) => const Center(
                              child: Icon(Icons.image_not_supported, size: 40),
                            ),
                          ),
                        ),
                      ),
                      Gap(50),
                      // Text Content Section
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Product Name (single line)
                              Text(
                                product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              // Product Description (max two lines)
                              if (product.description != null)
                                Text(
                                  product.description,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              const SizedBox(height: 6),
                              // Price (single line)
                              Text(
                                '${product.price} ${product.currency}',
                                style: const TextStyle(
                                  color: Colors.teal,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
