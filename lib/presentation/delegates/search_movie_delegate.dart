import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:cinehub/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../domain/entities/movie.dart';

typedef SearchMoviesCallback = Future<List<Movie>> Function(String query);

class SearchMovieDelegate extends SearchDelegate<Movie?> {

  final SearchMoviesCallback searchMovies;
  StreamController<List<Movie>> debouncesMovies = StreamController.broadcast();
  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.searchMovies
  });

  void clearStreams() {
    debouncesMovies.close();
  }

  void _onQueryChanged(String query) {
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }
    _debounceTimer = Timer(const Duration(milliseconds: 500), () async {
      if (query.isEmpty) {
        debouncesMovies.add([]);
        return;
      }
      final movies = await searchMovies(query);
      debouncesMovies.add(movies);
    });
  }

  @override
  String get searchFieldLabel => 'Buscar Película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        FadeIn(
          animate: query.isNotEmpty,
          child: IconButton(
            onPressed: () => query = '',
            icon: const Icon(Iconsax.close_square_outline)
          ),
        )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        clearStreams();
        close(context, null);
      },
      icon: Icon(Icons.arrow_back_ios_new_outlined)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('BuildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    _onQueryChanged(query);

    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerLowest,
      child: StreamBuilder(
        stream: debouncesMovies.stream,
        builder: (context, snapshot) {
          final movies = snapshot.data ?? [];
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) => _MovieItem(
              movie: movies[index],
              onMovieSelected: (context, movie) {
                clearStreams();
                close(context, movie);
              },
            )
          );
        },
      ),
    );
  }

}

class _MovieItem extends StatelessWidget {

  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({required this.movie, required this.onMovieSelected});

  @override
  Widget build(BuildContext context) {
    
    final textStyles = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

      return GestureDetector(
        onTap: () {
          onMovieSelected(context, movie);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              // Imagen de la película
              SizedBox(
                width: size.width * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    movie.posterPath,
                    loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                  ),
                ),
              ),
        
              const SizedBox(width: 5),
        
              // Detalles de la película
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título de la película
                      Text(
                        movie.title,
                        style: textStyles.titleLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis
                      ),
        
                      const SizedBox(height: 5),
        
                      // Descripción de la película
                      Text(
                        movie.overview,
                        style: textStyles.bodySmall,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
        
                      const SizedBox(height: 5),
        
                      // Calificación de la película
                      Row(
                        children: [
                          Icon(EvaIcons.star, color: Colors.yellow.shade800, size: 20),
                          const SizedBox(width: 5),
                          Text(
                            HumanFormats.number(movie.voteAverage, decimalDigits: 1),
                            style: textStyles.bodyMedium!.copyWith(color: Colors.yellow.shade800)
                          ),
                        ],
                      ),
        
                    ],
                  ),
                ),
              ),
            ],
          ),
            ),
      );
  }
}