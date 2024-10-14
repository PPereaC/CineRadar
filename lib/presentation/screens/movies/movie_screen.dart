import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../domain/entities/movie.dart';
import '../../providers/providers.dart';
import '../../widgets/widgets.dart';

class MovieScreen extends ConsumerStatefulWidget {

  static const name = 'movie-screen';

  final String movieId;

  const MovieScreen({super.key, required this.movieId});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {

  @override
  void initState() {
    super.initState();
    
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieId);
    ref.read(teasersByMovieProvider.notifier).loadTeasers(widget.movieId);

  }

  @override
  Widget build(BuildContext context) {

    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if (movie == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator(strokeWidth: 2)));
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          CustomSliverAppBar(movie: movie),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _MovieDetails(movie: movie),
              childCount: 1
            )
          )
        ],
      ),
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;

  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if (actorsByMovie[movieId] == null) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    final actors = actorsByMovie[movieId]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
          child: Text(
            'Actores',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: actors.length,
            itemBuilder: (context, index) {
              final actor = actors[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: 120,
                child: Column(
                  children: [

                    // Foto del actor
                    FadeInRight(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          actor.profilePath,
                          height: 140,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Nombre del actor
                    Text(
                      actor.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),

                    // Personaje
                    Text(
                      actor.character!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),

                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _TeasersByMovie extends ConsumerWidget {

  final String movieId;

  const _TeasersByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref){
    final teasersByMovie = ref.watch(teasersByMovieProvider);

    if (teasersByMovie[movieId] == null) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2));
    }

    final teasers = teasersByMovie[movieId]!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        if (teasers.isNotEmpty)
          // Título de la sección
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 3),
            child: Text(
              'Trailers',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        
        if (teasers.isNotEmpty)
          // Lista de teasers con pre visualización de video
          SizedBox(
            height: 170,
            child: ListView.builder(
              padding: const EdgeInsets.all(5),
              scrollDirection: Axis.horizontal,
              itemCount: teasers.length,
              itemBuilder: (context, index) {
                final teaser = teasers[index];
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => TeaserDialog(videoKey: teaser.key),
                    );
                  },
                  child: Container(
                    width: 250,
                    margin: const EdgeInsets.only(right: 8),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://img.youtube.com/vi/${teaser.key}/hqdefault.jpg',
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black.withOpacity(0.3),
                            ),
                            child: Center(
                              child: Icon(
                                Iconsax.play_circle_outline,
                                size: 40,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          left: 10,
                          right: 10,
                          child: Text(
                            teaser.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

        if (teasers.isNotEmpty)
          const SizedBox(height: 10),

      ],
    );

  }

}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyles = Theme.of(context).textTheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Column(
                children: [
                  // Título y puntuación
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          movie.title,
                          style: textStyles.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 24),
                          const SizedBox(width: 4),
                          Text(
                            '${movie.voteAverage.toStringAsFixed(1)}/10',
                            style: textStyles.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Descripción
                  Text(
                    movie.overview,
                    style: textStyles.bodyLarge,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Géneros
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  ...movie.genreIds.map((gender) {
                    final colors = Theme.of(context).colorScheme;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      child: Chip(
                        label: Text(gender),
                        backgroundColor: colors.primary,
                        labelStyle: TextStyle(color: colors.onPrimary),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Mostrar actores con título
            _ActorsByMovie(movieId: movie.id.toString()),

            const SizedBox(height: 10),

            // Mostrar teasers con título
            _TeasersByMovie(movieId: movie.id.toString()),

          ],
        ),
      ),
    );
  }
}