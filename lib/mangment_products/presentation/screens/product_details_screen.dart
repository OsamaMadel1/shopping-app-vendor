import 'package:app_vendor/authentication/application/providers/auth_notifier_provider.dart';
import 'package:app_vendor/mangment_products/application/providers/get_product_by_id_provider.dart';
import 'package:app_vendor/mangment_products/application/providers/product_notifier_provider.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsScreen extends ConsumerWidget {
  final String id;

  const ProductDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(getProductByIdProvider(id));
    final shopId = ref.read(authNotifierProvider).shopId;

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('details product'.i18n)),
        centerTitle: true,
        elevation: 0,
      ),

      body: productAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) =>
            const Center(child: Text('حدث خطأ أثناء تحميل المنتج')),
        data: (product) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // ✅ الصورة
                Hero(
                  tag: 'product-${product.id}',
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        product.image.isNotEmpty
                            ? product.image
                            : 'https://via.placeholder.com/300x200.png?text=No+Image',
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(
                              Icons.broken_image,
                              size: 60,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const Gap(10),

                // ✅ الاسم والسعر
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name.i18n,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${product.currency}${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),

                const Gap(10),

                // ✅ التصنيف
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'categorey: ${product.categoryName ?? "not".i18n}',
                  ),
                ),

                const Gap(10),

                // ✅ الوصف داخل Scroll مع مساحة مرنة
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        product.description.isNotEmpty
                            ? product.description.i18n
                            : 'not description'.i18n,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),

                const Gap(20),

                // ✅ الأزرار
                Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () => context.pushNamed(
                          'editProductScreen',
                          extra: product,
                        ),
                        icon: const Icon(Icons.edit_outlined),
                        label: Text('update'.i18n),
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.orange[700],
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Delete Product'.i18n),
                            content: Text('هل أنت متأكد من حذف هذا المنتج؟'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text('cancel'.i18n),
                              ),
                              TextButton(
                                onPressed: () {
                                  ref
                                      .read(productNotifierProvider.notifier)
                                      .deleteProduct(
                                        id,
                                        shopId: shopId,
                                        categoryName: product.categoryName,
                                      );
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('تم حذف المنتج'),
                                    ),
                                  );
                                },
                                child: Text(
                                  'delete'.i18n,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ),
                        icon: const Icon(Icons.delete_outline),
                        label: Text('delete'.i18n),
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.red[700],
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
