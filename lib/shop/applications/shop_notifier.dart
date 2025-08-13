import 'package:app_vendor/shop/applications/shop_state.dart';
import 'package:app_vendor/shop/domain/entities/shop_entity.dart';
import 'package:app_vendor/shop/domain/use_cases/delete_shop_use_case.dart';
import 'package:app_vendor/shop/domain/use_cases/get_all_shops_use_case.dart';
import 'package:app_vendor/shop/domain/use_cases/get_shop_by_id_use_case.dart';
import 'package:app_vendor/shop/domain/use_cases/update_shop_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShopNotifier extends StateNotifier<ShopState> {
  final GetAllShopsUseCase getAllShopsUseCase;
  final GetShopByIdUseCase getShopByIdUseCase;
  final UpdateShopUseCase updateShopUseCase;
  final DeleteShopUseCase deleteShopUseCase;

  ShopNotifier({
    required this.getAllShopsUseCase,
    required this.getShopByIdUseCase,
    required this.updateShopUseCase,
    required this.deleteShopUseCase,
  }) : super(const ShopState.initial());

  Future<void> fetchAllShops() async {
    state = const ShopState.loading();
    try {
      final shops = await getAllShopsUseCase();
      state = ShopState.loaded(shops);
    } catch (e) {
      state = ShopState.error(e.toString());
    }
  }

  Future<void> fetchShopById(String id) async {
    state = const ShopState.loading();
    try {
      final shop = await getShopByIdUseCase(id);
      state = ShopState.singleLoaded(shop);
    } catch (e) {
      state = ShopState.error(e.toString());
    }
  }

  Future<void> updateShop(ShopEntity shop) async {
    state = const ShopState.loading();
    try {
      await updateShopUseCase(shop);
      // إعادة جلب بيانات المتجر المحدث لعرضها
      final updatedShop = await getShopByIdUseCase(shop.id!);
      state = ShopState.singleLoaded(updatedShop);
      // state = const ShopState.success("Shop updated successfully");
    } catch (e) {
      state = ShopState.error(e.toString());
    }
  }

  // shop_notifier.dart
  Future<bool> deleteShop(String id) async {
    state = const ShopState.loading();
    try {
      await deleteShopUseCase(id);
      state = const ShopState.success("Shop deleted successfully");
      return true;
    } catch (e) {
      state = ShopState.error(e.toString());
      return false;
    }
  }
}
