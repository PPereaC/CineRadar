import 'package:cinehub/domain/datasources/genres_datasource.dart';
import 'package:cinehub/domain/entities/genre.dart';
import 'package:cinehub/domain/repositories/genres_repository.dart';

class GenreRepositoryImpl extends GenresRepository{

  final GenresDatasource datasource;

  GenreRepositoryImpl({required this.datasource});

  @override
  Future<List<Genre>> getMoviesGenres() {
    return datasource.getMoviesGenres();
  } 

}