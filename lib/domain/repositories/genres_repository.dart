import '../entities/genre.dart';
import '../entities/movie.dart';

abstract class GenresRepository {

  Future<List<Genre>> getMoviesGenres();

  Future<List<Movie>> getMoviesByGenre(int genreId, {int page = 0});

}