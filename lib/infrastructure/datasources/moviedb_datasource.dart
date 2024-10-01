import 'package:cinehub/config/constants/environment.dart';
import 'package:cinehub/domain/datasources/movies_datasource.dart';
import 'package:cinehub/domain/entities/movie.dart';

import 'package:cinehub/infrastructure/mappers/movie_mapper.dart';
import 'package:cinehub/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MoviedbDatasource extends MoviesDatasource {
  
  final dio = Dio(BaseOptions(
    baseUrl:  'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMovieDBKey,
      'language': 'es-ES'
    }
  ));

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
  Future<List<Movie>> getNowPlaying({int page = 1}) async {

    final response = await dio.get('/movie/now_playing', 
    queryParameters: {
      'page': page
    });

    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) async {

    final response = await dio.get('/movie/popular', 
    queryParameters: {
      'page': page
    });

    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getUpcoming({int page = 1}) async {
    final response = await dio.get('/movie/upcoming', 
    queryParameters: {
      'page': page,
    });

    return _jsonToMovies(response.data);
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response = await dio.get('/movie/top_rated', 
    queryParameters: {
      'page': page,
      'region': 'ES'
    });

    return _jsonToMovies(response.data);
  }

}