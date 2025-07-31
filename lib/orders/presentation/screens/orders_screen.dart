import 'package:app_vendor/authentication/application/providers/auth_notifier_provider.dart';
import 'package:app_vendor/orders/application/order_state.dart';
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
  late String? shopId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final shop = ref.read(authNotifierProvider);
      shopId = shop.shopId;
      if (shopId != null) {
        print('📦 Initializing orders for shopId: $shopId');
        ref.read(orderNotifierProvider.notifier).loadOrders(shopId!);
      }
    });
  }

  Future<void> _refreshOrders() async {
    if (shopId != null) {
      await ref.read(orderNotifierProvider.notifier).loadOrders(shopId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(orderNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: Center(child: Text('orders'.i18n))),
      body: state.when(
        initial: () => const SizedBox.shrink(),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (message) => Center(child: Text('حدث خطأ: $message')),
        loaded: (orders) {
          if (orders.isEmpty) {
            return Center(child: Text('not orders'.i18n));
          }

          return RefreshIndicator(
            onRefresh: _refreshOrders,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    title: Text(
                      '${'order'.i18n} #${order.id.length <= 6 ? order.id : order.id.substring(0, 6)}',
                    ),
                    subtitle: Text(
                      '${'Status'.i18n}: ${order.orderState}\n${'total amount'.i18n}: ${order.totalAmount}',
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
            ),
          );
        },
      ),
    );
  }
}
