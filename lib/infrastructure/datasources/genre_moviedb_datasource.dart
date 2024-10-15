import 'package:cinehub/config/constants/environment.dart';
import 'package:cinehub/domain/entities/genre.dart';
import 'package:dio/dio.dart';

import '../../domain/datasources/genres_datasource.dart';
import '../models/moviedb/categories_response.dart';

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

}