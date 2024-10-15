import 'package:cinehub/domain/entities/genre.dart';

import '../entities/movie.dart';

abstract class GenresDatasource {

  Future<List<Genre>> getMoviesGenres();

  Future<List<Movie>> getMoviesByGenre(int genreId, {int page = 0});

}