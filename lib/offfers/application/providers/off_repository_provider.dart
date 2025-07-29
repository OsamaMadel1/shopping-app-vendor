import 'package:app_vendor/offfers/data/repositories/off_repository_impl.dart';
import 'package:app_vendor/offfers/domain/repositories/off_repositories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'off_remote_data_source_provider.dart';

final offRepositoryProvider = Provider<OffRepository>((ref) {
  final remoteDataSource = ref.read(offRemoteDataSourceProvider);
  return OffRepositoryImpl(remoteDataSource);
});
