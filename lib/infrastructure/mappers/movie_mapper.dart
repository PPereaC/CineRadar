import 'package:cinehub/domain/entities/movie.dart';
import 'package:cinehub/infrastructure/models/moviedb/movie_moviedb.dart';

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
    : 'no-poster',
    releaseDate: moviedb.releaseDate,
    title: moviedb.title,
    video: moviedb.video,
    voteAverage: moviedb.voteAverage,
    voteCount: moviedb.voteCount
  );

}