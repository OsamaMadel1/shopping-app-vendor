import 'package:app_vendor/authentication/application/providers/auth_notifier_provider.dart';
import 'package:app_vendor/orders/application/providers/order_notifier_provider.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final shop = ref.read(authNotifierProvider); // ✅ الصواب
      final shopId = shop.shopId;
      if (shopId != null) {
        ref.read(orderNotifierProvider.notifier).loadOrders(shopId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Center(child: Text('orders'.i18n))),
      body: Builder(
        builder: (context) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text('حدث خطأ: ${state.error}'));
          }

          if (state.orders.isEmpty) {
            return Center(child: Text('not orders'.i18n));
          }

          return ListView.builder(
            itemCount: state.orders.length,
            itemBuilder: (context, index) {
              final order = state.orders[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text('order #${order.id.substring(0, 6)}'.i18n),
                  subtitle: Text(
                    'state: ${order.orderState}\n'
                            'amount: ${order.totalAmount}'
                        .i18n,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    context.pushNamed(
                      'orderDetailsScreen',
                      pathParameters: {'id': order.id},
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
