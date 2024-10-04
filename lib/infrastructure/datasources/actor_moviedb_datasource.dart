import 'package:cinehub/config/constants/environment.dart';
import 'package:cinehub/domain/datasources/actors_datasource.dart';
import 'package:cinehub/domain/entities/actor.dart';
import 'package:cinehub/infrastructure/mappers/actor_mapper.dart';
import 'package:dio/dio.dart';

import '../models/moviedb/credits_response.dart';

class ActorMoviedbDatasource extends ActorsDatasource{

  final dio = Dio(BaseOptions(
    baseUrl:  'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key': Environment.theMovieDBKey,
      'language': 'es-ES'
    }
  ));

  List<Actor> _jsonToActors(Map<String, dynamic> json) {

    final creditsResponse = CreditsResponse.fromJson(json);
    
    final List<Actor> actors = creditsResponse.cast
    .where((cast) => cast.profilePath != 'no-poster')
    .map(
      (cast) => ActorMapper.castToEntity(cast)
    ).toList();

    return actors;
  }

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    
    final response = await dio.get('/movie/$movieId/credits');

    return _jsonToActors(response.data);

  }

}