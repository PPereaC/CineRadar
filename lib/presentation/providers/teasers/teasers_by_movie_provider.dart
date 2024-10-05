import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/teaser.dart';
import '../providers.dart';

final teasersByMovieProvider = StateNotifierProvider<TeasersByMovieProvider, Map<String, List<Teaser>>>((ref) {
  final getTeasers = ref.watch(teasersRepositoryProvider).getTeasersByMovie;

  return TeasersByMovieProvider(
    getTeasers: getTeasers
  );
});

typedef GetTeasersCallback = Future<List<Teaser>>Function(String movieId);

class TeasersByMovieProvider extends StateNotifier<Map<String, List<Teaser>>> {

  final GetTeasersCallback getTeasers;

  TeasersByMovieProvider({
    required this.getTeasers
  }): super({});

  Future<void> loadTeasers(String movieId) async {

    if (state[movieId] != null) return;

    final teasers = await getTeasers(movieId);

    state = {... state, movieId: teasers};

  }

}