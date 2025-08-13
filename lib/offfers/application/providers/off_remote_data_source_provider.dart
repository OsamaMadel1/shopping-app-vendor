import 'package:app_vendor/authentication/application/providers/dio_provider.dart';
import 'package:app_vendor/offfers/data/sources/remotes/off_remote_date_source.dart';
import 'package:app_vendor/offfers/data/sources/remotes/off_remote_date_source_impl.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final offRemoteDataSourceProvider = Provider<OffRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return OffRemoteDataSourceImpl(dio);
});
