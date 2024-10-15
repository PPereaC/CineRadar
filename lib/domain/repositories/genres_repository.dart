import 'package:cinehub/domain/entities/genre.dart';

abstract class GenresRepository {

  Future<List<Genre>> getMoviesGenres();

}