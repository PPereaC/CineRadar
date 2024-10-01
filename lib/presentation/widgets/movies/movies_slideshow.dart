import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

import '../../../domain/entities/movie.dart';


class MoviesSlideshow extends StatelessWidget {
  
  final List<Movie> movies;
  
  const MoviesSlideshow({
    super.key, 
    required this.movies
  });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    //* Swiper de películas
    return Container(
      color: Colors.transparent,
      child: SizedBox(
        height: 210,
        width: double.infinity,
        child: Swiper(
          viewportFraction: 0.8,
          scale: 0.9,
          autoplay: true,
          pagination: SwiperPagination(
            margin: const EdgeInsets.only(top: 0),
            builder: DotSwiperPaginationBuilder(
              activeColor: colors.primary,
              color: colors.secondary
            )
          ),
          itemCount: movies.length,
          itemBuilder: (context, index) => _Slide(movie: movies[index] ),
        ),
      ),
    );

  }
}


class _Slide extends StatelessWidget {

  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {

    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Colors.black45,
          blurRadius: 10,
          offset: Offset(0, 10)
        )
      ]
    );

    return Padding(
      padding: const EdgeInsets.only( bottom: 30 ),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [

              //* Imagen de la película de fondo
              Image.network(
                movie.backdropPath,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if ( loadingProgress != null ) {
                    return const DecoratedBox(
                      decoration: BoxDecoration( color: Colors.black12 )
                    );
                  }
                  return FadeIn(child: child);
                },
              ),

              //* Título de la película
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black54],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Text(
                    movie.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

            ]
            
          )
        )
      ),
    );
  }
}