import 'package:cinemapedia/config/constants/enviroment.dart';
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MovieDbDatasource extends MoviesDatasource{
  //variable de tipo Dio (clase parecida a http), para guardar la base de url de api 
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3',
    queryParameters: {
      'api_key'   : Enviroment.movieDbKey, //API key
      'language'  : 'es-MX' //lenguaje
    }
  ));


  //metodo asincrono que devuelve una lista de objetos de tipos "Clase"
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async{
    
    final response = await dio.get('/movie/now_playing'); //obtengo la data de la extension
    final movieDBResponse =  MovieDbResponse.fromJson(response.data); //guardo el json de la data de que viene de la variable "response"

    //guardamos en la variable "movies",  el resultado de la Iterable obtenida por método ".map()" creado a partir de una lista de la instancia de clase y método "movieDBResponse.fromJson"(results), en base a conversion con el mètodo "MovieMapper.movieDBToEntity" para obtener el mismo listado en formato distinto(Movie) y finalmente se transforma en una lista con ".toList()"
    //results serian las peliculas con el formato MovieMovieDB
    final List<Movie> movies = movieDBResponse.results
    .where((moviedb) => moviedb.posterPath != 'no-poster') //para "filtrar" con estas opciones, si es distinto de 'no-poster' lo deja pasar
    .map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
    ).toList();

    return movies;
  }


}