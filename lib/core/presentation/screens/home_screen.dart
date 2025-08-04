import 'package:app_vendor/core/presentation/widgets/dash_board_card_widget.dart';
import 'package:app_vendor/translations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Control Panel'.i18n))),
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
              backgroundColor: cardBackgroundColors[2], // أخضر فاتح
              iconColor: cardIconColors[2], // أخضر غامق
              onTap: () {
                context.push('/productScreen');
              },
            ),
            DashBoardCardWidget(
              icon: Icons.receipt_long,
              text: 'Orders'.i18n,
              backgroundColor: cardBackgroundColors[1], // برتقالي فاتح
              iconColor: cardIconColors[1], // برتقالي غامق
              onTap: () {
                context.push('/ordersScreen');
              },
            ),
            DashBoardCardWidget(
              icon: Icons.local_offer,
              text: 'Offers'.i18n,
              backgroundColor: cardBackgroundColors[0], // أزرق فاتح
              iconColor: cardIconColors[0], // أزرق غامق
              onTap: () {
                context.push('/offerScreen');
              },
            ),
            DashBoardCardWidget(
              icon: Icons.attach_money,
              text: 'Sales'.i18n,
              backgroundColor: cardBackgroundColors[5], // سماوي فاتح
              iconColor: cardIconColors[5], // سماوي غامق
              onTap: () {},
            ),
            DashBoardCardWidget(
              icon: Icons.bar_chart,
              text: 'Reporters'.i18n,
              backgroundColor: cardBackgroundColors[4], // أصفر فاتح
              iconColor: cardIconColors[4], // أصفر غامق
              onTap: () {},
            ),

            DashBoardCardWidget(
              icon: Icons.settings,
              text: 'Settings'.i18n,
              backgroundColor: cardBackgroundColors[3], // وردي فاتح
              iconColor: cardIconColors[3], // أحمر غامق
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

final List<Color> cardBackgroundColors = [
  Color(0xFFE3F2FD), // أزرق فاتح
  Color(0xFFFFF3E0), // برتقالي فاتح
  Color(0xFFE8F5E9), // أخضر فاتح
  Color(0xFFFFEBEE), // وردي فاتح
  Color(0xFFFFFDE7), // أصفر فاتح
  Color(0xFFE1F5FE), // سماوي فاتح
];

final List<Color> cardIconColors = [
  Color(0xFF1976D2), // أزرق غامق
  Color(0xFFF57C00), // برتقالي غامق
  Color(0xFF388E3C), // أخضر غامق
  Color(0xFFD32F2F), // أحمر غامق
  Color(0xFFFBC02D), // أصفر غامق
  Color(0xFF0288D1), // سماوي غامق
];
