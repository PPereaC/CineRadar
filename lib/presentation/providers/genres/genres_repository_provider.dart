import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/datasources/genre_moviedb_datasource.dart';
import '../../../infrastructure/repositories/genre_repository_impl.dart';

final genresRepositoryProvider = Provider<GenreRepositoryImpl>((ref) {
  final datasource = GenreMoviedbDatasource();
  return GenreRepositoryImpl(datasource: datasource);
});