import 'package:cinehub/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinehub/infrastructure/repositories/actor_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final actorsRepositoryProvider = Provider((ref) => 
  ActorRepositoryImpl(datasource: ActorMoviedbDatasource())
);