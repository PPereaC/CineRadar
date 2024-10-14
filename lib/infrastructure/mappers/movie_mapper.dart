import 'package:cinehub/domain/entities/movie.dart';
import 'package:cinehub/infrastructure/models/moviedb/movie_moviedb.dart';

import '../models/moviedb/movie_details.dart';

class MovieMapper {

  static Movie movieDBtoEntity(MovieMovieDB moviedb) => Movie(
    adult: moviedb.adult,
    backdropPath: (moviedb.backdropPath != '') 
    ? 'https://image.tmdb.org/t/p/w500${moviedb.backdropPath}'
    : 'https://m.media-amazon.com/images/I/61s8vyZLSzL.jpg',
    genreIds: moviedb.genreIds.map((e) => e.toString()).toList(),
    id: moviedb.id,
    originalLanguage: moviedb.originalLanguage,
    originalTitle: moviedb.originalTitle,
    overview: moviedb.overview,
    popularity: moviedb.popularity,
    posterPath: (moviedb.posterPath != '')
    ? 'https://image.tmdb.org/t/p/w500${moviedb.posterPath}'
    : 'https://www.movienewz.com/img/films/poster-holder.jpg',
    releaseDate: moviedb.releaseDate != null ? moviedb.releaseDate! : DateTime.now(),
    title: moviedb.title,
    video: moviedb.video,
    voteAverage: moviedb.voteAverage,
    voteCount: moviedb.voteCount
  );

  static Movie movieDetailsToEntity(MovieDetails movie) => Movie(
    adult: movie.adult,
    backdropPath: (movie.backdropPath != '') 
    ? 'https://image.tmdb.org/t/p/w500${movie.backdropPath}'
    : 'https://m.media-amazon.com/images/I/61s8vyZLSzL.jpg',
    genreIds: movie.genres.map((e) => e.name).toList(),
    id: movie.id,
    originalLanguage: movie.originalLanguage,
    originalTitle: movie.originalTitle,
    overview: movie.overview,
    popularity: movie.popularity,
    posterPath: (movie.posterPath != '')
    ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
    : 'https://m.media-amazon.com/images/I/61s8vyZLSzL.jpg',
    releaseDate: movie.releaseDate,
    title: movie.title,
    video: movie.video,
    voteAverage: movie.voteAverage,
    voteCount: movie.voteCount
  );

  static Movie fromSqfliteMap(Map<String, dynamic> movie) => Movie(
    adult: movie['adult'] == 1,
    backdropPath: movie['backdropPath'],
    genreIds: movie['genreIds'].split(','),
    id: movie['id'],
    originalLanguage: movie['originalLanguage'],
    originalTitle: movie['originalTitle'],
    overview: movie['overview'],
    popularity: movie['popularity'],
    posterPath: movie['posterPath'],
    releaseDate: DateTime.parse(movie['releaseDate']),
    title: movie['title'],
    video: movie['video'] == 1,
    voteAverage: movie['voteAverage'],
    voteCount: movie['voteCount']
  );

}