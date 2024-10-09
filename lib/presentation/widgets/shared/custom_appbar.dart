import 'package:cinehub/presentation/delegates/search_movie_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

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
                onPressed: () {

                  final movieRepository = ref.read(movieRepositoryProvider);

                  showSearch(
                    context: context,
                    delegate: SearchMovieDelegate(
                      searchMovies: movieRepository.searchMovies
                    )
                  );
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