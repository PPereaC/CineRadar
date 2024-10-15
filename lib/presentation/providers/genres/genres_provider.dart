import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinehub/domain/entities/genre.dart';
import 'package:cinehub/presentation/providers/genres/genres_repository_provider.dart';
import '../../../domain/entities/movie.dart';

final genresProvider = FutureProvider<List<Genre>>((ref) {
  final genresRepository = ref.watch(genresRepositoryProvider);
  return genresRepository.getMoviesGenres();
});

final moviesByGenreProvider = StateNotifierProvider.family<MoviesByGenreNotifier, List<Movie>, int>((ref, genreId) {
  fetchMoreMovies({required int genreId, int page = 0}) {
    return ref.watch(genresRepositoryProvider).getMoviesByGenre(genreId, page: page);
  }
  return MoviesByGenreNotifier(
    fetchMoreMovies: fetchMoreMovies,
    genreId: genreId,
  );
});

typedef MoviesByGenreCallback = Future<List<Movie>> Function({required int genreId, int page});

class MoviesByGenreNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  bool isLoading = false;
  final MoviesByGenreCallback fetchMoreMovies;
  final int genreId;

  MoviesByGenreNotifier({
    required this.fetchMoreMovies,
    required this.genreId,
  }) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;

    isLoading = true;
    currentPage++;

    final List<Movie> movies = await fetchMoreMovies(genreId: genreId, page: currentPage);
    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 500));
    isLoading = false;
  }
}