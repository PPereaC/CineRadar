import 'package:cinehub/infrastructure/datasources/teaser_moviedb_datasource.dart';
import 'package:cinehub/infrastructure/repositories/teaser_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final teasersRepositoryProvider = Provider((ref) => 
  TeaserRepositoryImpl(datasource: TeaserMoviedbDatasource())
);