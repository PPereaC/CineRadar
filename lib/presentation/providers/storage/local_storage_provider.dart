import 'package:cinehub/infrastructure/repositories/local_storage_repository_impl.dart';
import 'package:cinehub/infrastructure/datasources/sqflite_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider((ref) {
  final sqfliteDatasource = SQFliteDatasource();
  return LocalStorageRepositoryImpl(sqfliteDatasource);
});