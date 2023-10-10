import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MovieDatasource{
  //definimos comportamiento
  // traer peliculas en cartelera especificando la pagina con retorno de un "Future" de una "list" de "Movie"
  Future<List<Movie>> getNowPlaying({ int page = 1 });


}