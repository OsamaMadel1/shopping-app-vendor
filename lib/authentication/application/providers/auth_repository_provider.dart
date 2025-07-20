import 'package:app_vendor/authentication/data/providers/auth_local_data_source_provider.dart';
import 'package:app_vendor/authentication/data/providers/auth_remote_data_source_provider.dart';
import 'package:app_vendor/authentication/data/repositories/auth_repository_imp.dart';
import 'package:app_vendor/authentication/domain/repositories/auth_repositroy.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remote = ref.watch(authRemoteDataSourceProvider);
  final local = ref.watch(authLocalDataSourceProvider);

  return AuthRepositoryImpl(remoteDataSource: remote, localDataSource: local);
});
