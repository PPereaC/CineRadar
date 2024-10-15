import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinehub/domain/entities/genre.dart';
import 'package:cinehub/presentation/providers/genres/genres_repository_provider.dart';

final genresProvider = FutureProvider<List<Genre>>((ref) {
  final genresRepository = ref.watch(genresRepositoryProvider);
  return genresRepository.getMoviesGenres();
});