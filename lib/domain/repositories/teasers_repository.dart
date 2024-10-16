import '../entities/teaser.dart';

abstract class TeasersRepository {

  Future<List<Teaser>> getTeasersByMovie(String movieId);

}