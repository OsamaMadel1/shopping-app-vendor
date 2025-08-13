import 'package:app_vendor/authentication/application/providers/dio_provider.dart';
import 'package:app_vendor/shop/applications/shop_notifier.dart';
import 'package:app_vendor/shop/applications/shop_state.dart';
import 'package:app_vendor/shop/data/sources/remotes/shop_remote_data_source.dart';
import 'package:app_vendor/shop/data/sources/remotes/shop_remote_data_source_impl.dart';
import 'package:app_vendor/shop/domain/use_cases/delete_shop_use_case.dart';
import 'package:app_vendor/shop/domain/use_cases/get_all_shops_use_case.dart';
import 'package:app_vendor/shop/domain/use_cases/get_shop_by_id_use_case.dart';
import 'package:app_vendor/shop/domain/use_cases/update_shop_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app_vendor/shop/data/repositories/shop_repository_impl.dart';

/// Remote Data Source Provider
final shopRemoteDataSourceProvider = Provider<ShopRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return ShopRemoteDataSourceImpl(dio);
});

/// Repository Provider
final shopRepositoryProvider = Provider((ref) {
  final remoteDataSource = ref.watch(shopRemoteDataSourceProvider);
  return ShopRepositoryImpl(remoteDataSource);
});

/// UseCase Providers
final getAllShopsUseCaseProvider = Provider((ref) {
  return GetAllShopsUseCase(ref.watch(shopRepositoryProvider));
});

final getShopByIdUseCaseProvider = Provider((ref) {
  return GetShopByIdUseCase(ref.watch(shopRepositoryProvider));
});

final updateShopUseCaseProvider = Provider((ref) {
  return UpdateShopUseCase(ref.watch(shopRepositoryProvider));
});

final deleteShopUseCaseProvider = Provider((ref) {
  return DeleteShopUseCase(ref.watch(shopRepositoryProvider));
});

/// ShopNotifier Provider
final shopNotifierProvider = StateNotifierProvider<ShopNotifier, ShopState>((
  ref,
) {
  return ShopNotifier(
    getAllShopsUseCase: ref.watch(getAllShopsUseCaseProvider),
    getShopByIdUseCase: ref.watch(getShopByIdUseCaseProvider),
    updateShopUseCase: ref.watch(updateShopUseCaseProvider),
    deleteShopUseCase: ref.watch(deleteShopUseCaseProvider),
  );
});
