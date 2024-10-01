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

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {

    final response = await dio.get('/movie/now_playing', 
    queryParameters: {
      'page': page
    });

    final movieDBResponse = MovieDbResponse.fromJson(response.data);
    
    final List<Movie> movies = movieDBResponse.results
    .where((moviedb) => moviedb.posterPath != 'no-poster')
    .map(
      (moviedb) => MovieMapper.movieDBtoEntity(moviedb)
    ).toList();

    return movies;
  }

}