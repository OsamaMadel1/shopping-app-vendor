import 'package:app_vendor/offfers/application/off_notifier.dart';
import 'package:app_vendor/offfers/application/off_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'off_usecases_provider.dart';

final offNotifierProvider = StateNotifierProvider<OffNotifier, OffState>((ref) {
  final useCases = ref.read(offUseCasesProvider);
  return OffNotifier(useCases);
});
