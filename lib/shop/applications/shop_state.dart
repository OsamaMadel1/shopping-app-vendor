import 'package:flutter/src/widgets/basic.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:app_vendor/shop/domain/entities/shop_entity.dart';

part 'shop_state.freezed.dart';

@freezed
class ShopState with _$ShopState {
  const factory ShopState.initial() = _Initial;
  const factory ShopState.loading() = _Loading;
  const factory ShopState.loaded(List<ShopEntity> shops) = _Loaded;
  const factory ShopState.singleLoaded(ShopEntity shop) = _SingleLoaded;
  const factory ShopState.success(String message) = _Success;
  const factory ShopState.error(String message) = _Error;
}
