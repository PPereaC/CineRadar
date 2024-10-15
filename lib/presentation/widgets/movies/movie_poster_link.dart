import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/movie.dart';

class MoviePosterLink extends StatelessWidget {

  final Movie movie;

  const MoviePosterLink({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {

    // Valor aleatorio para el delay de la animación
    final random = Random();
    final delay = Duration(milliseconds: random.nextInt(800));

    return FadeInUp(
      delay: delay,
      child: GestureDetector(
        onTap: () => context.push('/movie/${movie.id}'),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeIn(
            child: Image.network(movie.posterPath),
          ),
        ),
      ),
    );
  }
}