import 'package:cinehub/domain/datasources/teasers_datasource.dart';
import 'package:cinehub/domain/entities/teaser.dart';
import 'package:cinehub/domain/repositories/teasers_repository.dart';

class TeaserRepositoryImpl extends TeasersRepository {

  final TeasersDatasource datasource;

  TeaserRepositoryImpl({required this.datasource});

  @override
  Future<List<Teaser>> getTeasersByMovie(String movieId) {
    return datasource.getTeasersByMovie(movieId);
  }

}