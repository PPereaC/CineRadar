import 'package:cinehub/presentation/delegates/search_movie_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../domain/entities/movie.dart';
import '../../providers/providers.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [

              // TODO: Cambiar por el logo de la app
              Icon(Icons.movie_outlined, color: colors.primary, size: 28,),

              const SizedBox(width: 10),
              
              Text('CineHub', style: titleStyle,),

              const Spacer(),

              IconButton(
                onPressed: () async {

                  final searchedMovies = ref.read(searchMoviesProvider);
                  final searchQuery = ref.read(searchQueryProvider);

                  final movie = await showSearch<Movie?>(
                    query: searchQuery,
                    context: context,
                    delegate: SearchMovieDelegate(
                      initialMovies: searchedMovies,
                      searchMovies: ref.read(searchMoviesProvider.notifier).searchMoviesByQuery
                    )
                  );

                  if (movie == null || !context.mounted) return;

                  context.push('/movie/${movie.id}');

                },
                icon: const Icon(Iconsax.search_normal_outline)
              ),

            ],
          ),
        ),
      ),
    );
  }
}