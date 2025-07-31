// import 'package:app_vendor/orders/domain/entities/order_entity.dart';

// class OrderState {
//   final bool isLoading;
//   final List<OrderEntity> orders;
//   final String? error;

//   const OrderState({
//     this.isLoading = false,
//     this.orders = const [],
//     this.error,
//   });

//   OrderState copyWith({
//     bool? isLoading,
//     List<OrderEntity>? orders,
//     String? error,
//   }) {
//     return OrderState(
//       isLoading: isLoading ?? this.isLoading,
//       orders: orders ?? this.orders,
//       error: error,
//     );
//   }

//   static const initial = OrderState();
// }

import 'package:app_vendor/orders/domain/entities/order_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_state.freezed.dart';

@freezed
class OrderState with _$OrderState {
  /// الحالة الابتدائية
  const factory OrderState.initial() = _Initial;

  /// عند التحميل
  const factory OrderState.loading() = _Loading;

  /// عند نجاح التحميل
  const factory OrderState.loaded(List<OrderEntity> orders) = _Loaded;

  /// عند فشل التحميل
  const factory OrderState.error(String message) = _Error;

  // تتبع حالة الطلب الواحد
  // const factory OrderState.singleLoaded(OrderEntity order) = _SingleLoaded;
}
