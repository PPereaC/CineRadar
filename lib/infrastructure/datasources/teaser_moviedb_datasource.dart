import 'package:dio/dio.dart';

import '../../config/constants/environment.dart';
import '../../domain/datasources/teasers_datasource.dart';
import '../../domain/entities/teaser.dart';
import '../mappers/teaser_mapper.dart';
import '../models/moviedb/teaser_response.dart';

class TeaserMoviedbDatasource extends TeasersDatasource{

  final dio = Dio(BaseOptions(
    baseUrl:  'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMovieDBKey,
      'language': 'es-ES'
    }
  ));

  List<Teaser> _jsonToTeasers(Map<String, dynamic> json) {

    final teasersResponse = TeaserResponse.fromJson(json);
    
    final List<Teaser> teasers = teasersResponse.results
    .map(
      (teaser) => TeaserMapper.teaserToEntity(teaser)
    ).toList();

    return teasers;
  }

  @override
  Future<List<Teaser>> getTeasersByMovie(String movieId) async {
    final response = await dio.get('/movie/$movieId/videos');

    return _jsonToTeasers(response.data);
  }

}