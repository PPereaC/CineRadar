import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/datasources/sqflite_datasource.dart';
import '../../../infrastructure/repositories/local_storage_repository_impl.dart';

final localStorageRepositoryProvider = Provider((ref) {
  final sqfliteDatasource = SQFliteDatasource();
  return LocalStorageRepositoryImpl(sqfliteDatasource);
});