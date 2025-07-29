import 'package:app_vendor/offfers/domain/entity/off_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'off_state.freezed.dart';

@freezed
class OffState with _$OffState {
  const factory OffState.initial() = _Initial;
  const factory OffState.loading() = _Loading;
  const factory OffState.loaded(List<OffEntity> offs) = _Loaded;
  const factory OffState.error(String message) = _Error;
}
