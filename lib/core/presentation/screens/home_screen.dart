import 'package:app_vendor/core/presentation/widgets/dash_board_card_widget.dart';
import 'package:app_vendor/core/presentation/widgets/text_widget.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: TextWidget(text: 'Control Panel'.i18n)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.0,
          children: [
            DashBoardCardWidget(
              icon: Icons.kitchen,
              text: 'Products'.i18n,
              backgroundColor: const Color(0xFFE8F5E9), // أخضر فاتح
              iconColor: Colors.green,
              onTap: () {
                context.push('/productScreen');
              },
            ),
            DashBoardCardWidget(
              icon: Icons.receipt_long,
              text: 'Orders'.i18n,
              backgroundColor: const Color(0xFFFFF3E0), // برتقالي فاتح
              iconColor: Colors.orange,
              onTap: () {
                context.push('/ordersScreen');
              },
            ),
            DashBoardCardWidget(
              icon: Icons.receipt_long,
              text: 'Sales'.i18n,
              backgroundColor: const Color(0xFFFFF3E0), // برتقالي فاتح
              iconColor: Colors.orange,
              onTap: () {
                //context.push('/ordersScreen');
              },
            ),
            DashBoardCardWidget(
              icon: Icons.bar_chart,
              text: 'Repoters'.i18n,
              backgroundColor: const Color(0xFFFFF8E1), // أصفر فاتح
              iconColor: Colors.amber,
              onTap: () {
                // context.push('/reportsScreen');
              },
            ),
            DashBoardCardWidget(
              icon: Icons.local_offer,
              text: 'Offers'.i18n,
              backgroundColor: const Color(0xFFFFF3E0), // برتقالي فاتح
              iconColor: Colors.amber,
              onTap: () {
                context.push('/offerScreen');
              },
            ),
            DashBoardCardWidget(
              icon: Icons.settings,
              text: 'settings'.i18n,
              backgroundColor: const Color(0xFFFFEBEE), // وردي فاتح
              iconColor: Colors.redAccent,
              onTap: () {
                context.push('/settingsScreen');
              },
            ),
          ],
        ),
      ),
    );
  }
}
