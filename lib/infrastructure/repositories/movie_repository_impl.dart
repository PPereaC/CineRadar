import 'package:cinehub/domain/datasources/movies_datasource.dart';
import 'package:cinehub/domain/entities/movie.dart';
import 'package:cinehub/domain/repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {

  final MoviesDatasource datasource;

  MovieRepositoryImpl({required this.datasource});

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

}