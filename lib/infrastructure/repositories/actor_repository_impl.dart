import 'package:cinehub/domain/datasources/actors_datasource.dart';
import 'package:cinehub/domain/entities/actor.dart';
import 'package:cinehub/domain/repositories/actors_repository.dart';

class ActorRepositoryImpl extends ActorsRepository{

  final ActorsDatasource datasource;

  ActorRepositoryImpl({required this.datasource});

  @override
  Future<List<Actor>> getActorsByMovie(String movieId){
    return datasource.getActorsByMovie(movieId);
  }

}