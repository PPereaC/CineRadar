import 'package:cinehub/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinehub/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final movieRepositoryProvider = Provider((ref) => 
  MovieRepositoryImpl(datasource: MoviedbDatasource())
);