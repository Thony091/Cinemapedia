import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MoviesDatasource{
  //definimos comportamiento
  // traer peliculas en cartelera especificando la pagina con retorno de un "Future" de una "list" de "Movie"
  Future<List<Movie>> getNowPlaying({ int page = 1 });

  Future<List<Movie>> getPopular({ int page = 1 });

  Future<List<Movie>> getUpcoming({ int page = 1 });

  Future<List<Movie>> getTopRated({ int page = 1 });
}