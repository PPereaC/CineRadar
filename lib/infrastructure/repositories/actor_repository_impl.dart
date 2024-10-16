import 'package:cineradar/domain/datasources/actors_datasource.dart';
import 'package:cineradar/domain/entities/actor.dart';
import 'package:cineradar/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository{

  final ActorsDatasource datasource;

  ActorRepositoryImpl({required this.datasource});

  @override
  Future<List<Actor>> getActorsByMovie(String movieId){
    return datasource.getActorsByMovie(movieId);
  }

}