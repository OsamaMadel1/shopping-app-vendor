import 'package:app_vendor/offfers/domain/use_cases/offs_use_cases.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'off_repository_provider.dart';

final offUseCasesProvider = Provider<OffUseCases>((ref) {
  final repository = ref.read(offRepositoryProvider);
  return OffUseCases(repository);
});
