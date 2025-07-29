import 'package:app_vendor/api/errors/exceptions.dart';
import 'package:app_vendor/offfers/application/off_state.dart';
import 'package:app_vendor/offfers/domain/entity/off_entity.dart';
import 'package:app_vendor/offfers/domain/use_cases/offs_use_cases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OffNotifier extends StateNotifier<OffState> {
  final OffUseCases useCases;

  OffNotifier(this.useCases) : super(const OffState.initial());

  Future<void> loadOffs(String shopId) async {
    state = const OffState.loading();
    try {
      final offs = await useCases.getOffsByShop(shopId);
      state = OffState.loaded(offs);
    } catch (e) {
      final message = Exceptions.getMessage(e);
      state = OffState.error(message);
    }
  }

  Future<void> addOff(OffEntity off) async {
    state = const OffState.loading();
    try {
      await useCases.addOff(off);
      await _refreshOffs(off.shopId);
    } catch (e) {
      final message = Exceptions.getMessage(e);
      state = OffState.error(message);
    }
  }

  Future<void> updateOff(OffEntity off) async {
    state = const OffState.loading();
    try {
      await useCases.updateOff(off);
      await _refreshOffs(off.shopId);
    } catch (e) {
      final message = Exceptions.getMessage(e);
      state = OffState.error(message);
    }
  }

  Future<void> deleteOff(String id, {required String shopId}) async {
    state = const OffState.loading();
    try {
      await useCases.deleteOff(id);
      await _refreshOffs(shopId);
    } catch (e) {
      final message = Exceptions.getMessage(e);
      state = OffState.error(message);
    }
  }

  Future<void> _refreshOffs(String shopId) async {
    final offs = await useCases.getOffsByShop(shopId);
    state = OffState.loaded(offs);
  }
}
