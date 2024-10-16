import '../entities/teaser.dart';

abstract class TeasersDatasource {

  Future<List<Teaser>> getTeasersByMovie(String movieId);

}