import 'package:cinehub/domain/datasources/local_storage_datasource.dart';
import 'package:cinehub/domain/entities/movie.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../mappers/movie_mapper.dart';

class SQFliteDatasource extends LocalStorageDatasource {

  Future<Database> openDB() async {

    var databasesPath = await getDatabasesPath();

    // Construir la ruta completa de la base de datos
    String path = join(databasesPath, 'favorites_movies.db');
    
    // Abrir la base de datos
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE favMovies (
            id INTEGER PRIMARY KEY,
            adult INTEGER,
            backdropPath TEXT,
            genreIds TEXT,
            originalLanguage TEXT,
            originalTitle TEXT,
            overview TEXT,
            popularity REAL,
            posterPath TEXT,
            releaseDate TEXT,
            title TEXT,
            video INTEGER,
            voteAverage REAL,
            voteCount INTEGER
          )
          '''
        );
      },
    );
  }

  @override
  Future<bool> isMovieFavorite(int movieId) {
    
    // Abrir la base de datos
    return openDB().then((db) async {
      
      // Comprobar si la película está en la base de datos
      final List<Map<String, dynamic>> movies = await db.query(
        'favMovies',
        where: 'id = ?',
        whereArgs: [movieId]
      );

      return movies.isNotEmpty;

    });

  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    
    // Abrir la base de datos
    return openDB().then((db) async {
      
      // Obtener las películas favoritas
      final List<Map<String, dynamic>> movies = await db.query(
        'favMovies',
        limit: limit,
        offset: offset
      );

      // Mapear las películas favoritas a objetos Movie
      return movies.map((movie) => MovieMapper.fromSqfliteMap(movie)).toList();

    });

  }

  @override
  Future<void> toggleFavorite(Movie movie) {
    
    // Abrir la base de datos
    return openDB().then((db) async {
      
      // Comprobar si la película ya está en la base de datos
      final List<Map<String, dynamic>> movies = await db.query(
        'favMovies',
        where: 'id = ?',
        whereArgs: [movie.id]
      );

      // Si la película ya está en la base de datos, borrarla
      if (movies.isNotEmpty) {
        await db.delete(
          'movies',
          where: 'id = ?',
          whereArgs: [movie.id]
        );
        return;
      } else { // Si la película no está en la base de datos, insertarla
        await db.transaction((txn) async {
          await txn.rawInsert(
            '''
            INSERT INTO favMovies (
              id, 
              adult, 
              backdropPath, 
              genreIds, 
              originalLanguage, 
              originalTitle, 
              overview, 
              popularity, 
              posterPath, 
              releaseDate, 
              title, 
              video, 
              voteAverage, 
              voteCount
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ''',
            [
              movie.id,
              movie.adult ? 1 : 0,
              movie.backdropPath,
              movie.genreIds.join(','),
              movie.originalLanguage,
              movie.originalTitle,
              movie.overview,
              movie.popularity,
              movie.posterPath,
              movie.releaseDate.toIso8601String(),
              movie.title,
              movie.video ? 1 : 0,
              movie.voteAverage,
              movie.voteCount
            ]
          );
        });
      }

    });

  }

}