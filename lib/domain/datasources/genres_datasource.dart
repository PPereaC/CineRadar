import 'package:cinehub/domain/entities/genre.dart';

abstract class GenresDatasource {

  Future<List<Genre>> getMoviesGenres();

}