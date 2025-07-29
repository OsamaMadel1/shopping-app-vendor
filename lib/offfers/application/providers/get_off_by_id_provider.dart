import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'off_usecases_provider.dart';

final getOffByIdProvider = FutureProvider.family.autoDispose((
  ref,
  String id,
) async {
  final useCases = ref.watch(offUseCasesProvider);
  return useCases.getOffById(id);
});
