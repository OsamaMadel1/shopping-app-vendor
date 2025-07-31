import 'package:app_vendor/orders/application/providers/get_order_by_id_provider.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:gap/gap.dart';

class OrderDetailsScreen extends ConsumerWidget {
  final String id;

  const OrderDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderAsync = ref.watch(getOrderByIdProvider(id));

    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Order Details'.i18n))),
      body: orderAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('${'Error'.i18n}: $error')),
        data: (order) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${'order number'.i18n}: ${order.id.length >= 8 ? order.id.substring(0, 8) : order.id}'
                      .i18n,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(8),
                Text(
                  '${'order date'.i18n}: ${DateFormat('yyyy-MM-dd HH:mm').format(order.orderDate)}'
                      .i18n,
                ),
                const Gap(8),
                Text('${'Status'.i18n}: ${order.orderState}'.i18n),
                const Gap(8),
                Text('${'Total'.i18n}: ${order.totalAmount}'.i18n),
                const Gap(16),
                const Divider(),
                Center(
                  child: Text(
                    'Items'.i18n,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Gap(8),

                /// ✅ عناصر الطلب
                ...order.orderItems.map(
                  (item) => Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text('${'Name'.i18n}: ${item.productName}'),
                      subtitle: Text(
                        '${'Quantity'.i18n}: ${item.quantity}'.i18n,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text('Price'.i18n), Text('${item.price}')],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
