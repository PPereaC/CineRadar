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

    final isDarkModeActivated = ref.watch(themeNotifierProvider).isDarkmode;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [

              IconButton(
                icon: isDarkModeActivated 
                ? const Icon(Icons.dark_mode_outlined)
                : const Icon(Icons.light_mode_outlined),
                onPressed: () {
                  ref.read(themeNotifierProvider.notifier).toggleDarkmode();
                },
              ),

              const Spacer(),
              
              Center(
                child: Text(
                  'CineRadar',
                  style: TextStyle(
                    color: isDarkModeActivated ? Colors.white : Colors.black,
                    fontSize: 40,
                    fontFamily: 'Titulo'
                  ),
                ),
              ),

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