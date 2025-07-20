import 'package:app_vendor/core/application/navigator_provider.dart';
import 'package:app_vendor/core/presentation/components/bottom_app_bar_component.dart';
// import 'package:app_vendor/core/presentation/screens/home_screen.dart';
// import 'package:app_vendor/settings/presentation/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    var currentScreenIndex = ref.watch(navigationProvider);
    //var currenUser = ref.read(authNotifierProvider.notifier);

    return Scaffold(
      // floatingActionButton: MainIconButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBarComponent(
        currentScreenIndex: currentScreenIndex,
      ),
      body: IndexedStack(
        index: currentScreenIndex,
        children: const [
          // ProductScreen(), // currentScreenIndex = 0
          //   OrdersScreen(), // currentScreenIndex = 1
          // HomeScreen(), // currentScreenIndex = 2
          //SettingsScreen(), // currentScreenIndex = 3
          //SettingsScreen(), // currentScreenIndex = 4
          // CategoriesScreen(),
        ],
      ),
    );
  }
}
