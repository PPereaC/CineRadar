import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../infrastructure/datasources/teaser_moviedb_datasource.dart';
import '../../../infrastructure/repositories/teaser_repository_impl.dart';


final teasersRepositoryProvider = Provider((ref) => 
  TeaserRepositoryImpl(datasource: TeaserMoviedbDatasource())
);