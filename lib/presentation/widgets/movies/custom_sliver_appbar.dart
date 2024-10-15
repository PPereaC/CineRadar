import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../domain/entities/movie.dart';
import '../../providers/providers.dart';

final isFavoriteProvider = FutureProvider.family.autoDispose((ref, int movieId) {

  final localStorageRepository = ref.watch(localStorageRepositoryProvider);

  return localStorageRepository.isMovieFavorite(movieId); // [bool] Si está en favoritos
});

class CustomSliverAppBar extends ConsumerWidget {

  final Movie movie;

  const CustomSliverAppBar({super.key, required this.movie});

  @override
  Widget build(BuildContext context, ref) {

    final size = MediaQuery.of(context).size;
    final isFavoriteFuture = ref.watch(isFavoriteProvider(movie.id));

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () {
            // Llamar al método toggleFavorite del provider
            ref.watch(localStorageRepositoryProvider).toggleFavorite(movie).whenComplete(() {
              // Invalidar el provider isFavoriteProvider para que se recargue
              ref.invalidate(isFavoriteProvider(movie.id));
            });
          },
          icon: isFavoriteFuture.when(
            loading: () => CircularProgressIndicator(strokeWidth: 2),
            data: (isFavorite) => isFavorite
              ? const Icon(Iconsax.heart_bold, color: Colors.red)
              : const Icon(Iconsax.heart_outline),
            error: (_, __) => throw UnimplementedError(),
          ),
        ),
      ],
      leading: IconButton(
        onPressed: () {
          context.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios_new_outlined)
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [

            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),

            // Gradiente en la parte inferior de la imagen
            _CustomGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 0.2],
              colors: [Colors.black54, Colors.transparent]
            ),

            // Gradiente en la parte superior de la imagen
            _CustomGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.8, 1.0],
              colors: [Colors.transparent, Colors.black54]
            ),

            // Gradiente en la parte izquierda de la imagen
            _CustomGradient(
              begin: Alignment.topLeft,
              stops: [0.0, 0.3],
              colors: [Colors.black87, Colors.transparent]
            ),

          ],
        ),
      ),

    );
  }
}

class _CustomGradient extends StatelessWidget {

  final AlignmentGeometry begin;
  final AlignmentGeometry? end;
  final List<double> stops;
  final List<Color> colors;

  const _CustomGradient({
    required this.begin,
    this.end,
    required this.stops,
    required this.colors
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: end == null 
            ? LinearGradient(
                begin: begin,
                stops: stops,
                colors: colors,
              )
            : LinearGradient(
                begin: begin,
                end: end!,
                stops: stops,
                colors: colors,
              )
        ),
      ),
    );
  }
}