import 'package:app_vendor/core/presentation/widgets/text_widget.dart';
import 'package:app_vendor/orders/application/providers/get_order_by_id_provider.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class OrderDetailsScreen extends ConsumerWidget {
  final String id;

  const OrderDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderAsync = ref.watch(getOrderByIdProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: Center(child: TextWidget(text: 'details order'.i18n)),
      ),
      body: orderAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('خطأ: $error')),
        data: (order) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'order number: ${order.id.substring(0, 8)}'.i18n,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(8),
                Text(
                  'order date: ${DateFormat('yyyy-MM-dd HH:mm').format(order.orderDate)}'
                      .i18n,
                ),
                const Gap(8), Text('state: ${order.orderState}'.i18n),
                const Gap(8),
                Text('total: ${order.totalAmount}'.i18n),
                const Gap(16),
                const Divider(),
                Center(child: TextWidget(text: 'items'.i18n, fontSize: 16)),
                const Gap(8),

                /// ✅ العناصر
                ...order.orderItems.map(
                  (item) => Card(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text(item.productName),
                      subtitle: Text('quantity: ${item.quantity}'.i18n),
                      trailing: Text('${item.price}'),
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
