import 'package:cinehub/config/constants/environment.dart';
import 'package:cinehub/domain/entities/genre.dart';
import 'package:cinehub/domain/entities/movie.dart';
import 'package:dio/dio.dart';

import '../../domain/datasources/genres_datasource.dart';
import '../mappers/movie_mapper.dart';
import '../models/moviedb/categories_response.dart';
import '../models/moviedb/moviedb_response.dart';

class GenreMoviedbDatasource extends GenresDatasource{

  final dio = Dio(BaseOptions(
    baseUrl:  'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMovieDBKey,
      'language': 'es-ES'
    }
  ));

  List<Genre> _jsonToGenre(Map<String, dynamic> json) {

    // Obtener la respuesta (lista de géneros) y mapearla a una lista de categorías
    final categoriesResponse = GenresResponse.fromJson(json);

    return categoriesResponse.genres;

  }

  @override
  Future<List<Genre>> getMoviesGenres() async {
    final response = await dio.get('/genre/movie/list');
    return _jsonToGenre(response.data);
  }

  List<Movie> _jsonToMovies(Map<String, dynamic> json) {

    final movieDBResponse = MovieDbResponse.fromJson(json);
    
    final List<Movie> movies = movieDBResponse.results
    .where((moviedb) => moviedb.posterPath != 'no-poster')
    .map(
      (moviedb) => MovieMapper.movieDBtoEntity(moviedb)
    ).toList();

    return movies;
  }

  @override
  Future<List<Movie>> getMoviesByGenre(int genreId, {int page = 0}) async{
    final response = await dio.get(
      '/discover/movie',
      queryParameters: {
        'with_genres': genreId,
        'page': page
      }
    );
    
    return _jsonToMovies(response.data);
  }

}