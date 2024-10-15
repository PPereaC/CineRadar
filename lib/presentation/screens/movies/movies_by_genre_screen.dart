import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class MoviesByGenreScreen extends ConsumerStatefulWidget {

  static const name = 'movie-genre-screen';
  final int genreId;
  final String genreName;

  const MoviesByGenreScreen({super.key, required this.genreId, required this.genreName,});

  @override
  MoviesByGenreScreenState createState() => MoviesByGenreScreenState();
}

class MoviesByGenreScreenState extends ConsumerState<MoviesByGenreScreen> {

  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    ref.read(moviesByGenreProvider(widget.genreId).notifier).loadNextPage();
    loadNextPage();
  }

  void loadNextPage() async {

    if(isLoading || isLastPage) return;
    isLoading = true;

    await ref.read(moviesByGenreProvider(widget.genreId).notifier).loadNextPage();
    isLoading = false;

  }

  @override
  Widget build(BuildContext context) {

    final moviesAsyncValue = ref.watch(moviesByGenreProvider(widget.genreId));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Películas de ${widget.genreName}'),
      ),
      body: SafeArea(
        child: MovieMasonry(
          loadNextPage: loadNextPage,
          movies: moviesAsyncValue
        ),
      )
    );
  }
}
