import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinehub/infrastructure/repositories/genre_repository_impl.dart';
import 'package:cinehub/infrastructure/datasources/genre_moviedb_datasource.dart';

final genresRepositoryProvider = Provider<GenreRepositoryImpl>((ref) {
  final datasource = GenreMoviedbDatasource();
  return GenreRepositoryImpl(datasource: datasource);
});