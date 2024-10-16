import 'package:cineradar/domain/datasources/genres_datasource.dart';
import 'package:cineradar/domain/entities/genre.dart';
import 'package:cineradar/domain/entities/movie.dart';
import 'package:cineradar/domain/repositories/genres_repository.dart';

class GenreRepositoryImpl extends GenresRepository{

  final GenresDatasource datasource;

  GenreRepositoryImpl({required this.datasource});

  @override
  Future<List<Genre>> getMoviesGenres() {
    return datasource.getMoviesGenres();
  }

  @override
  Future<List<Movie>> getMoviesByGenre(int genreId, {int page = 0}) {
    return datasource.getMoviesByGenre(genreId, page: page);
  } 

}