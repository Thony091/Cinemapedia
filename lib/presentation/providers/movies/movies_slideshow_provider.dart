
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Mostrar solo 6 items
final moviesSlideShowProvider = Provider<List<Movie>> ((ref) {// especificar que es una lista de tipo pelicula

  final nowPlatingMovies = ref.watch(nowPlayingMoviesProvider);

  if( nowPlatingMovies.isEmpty ) return [];

  return nowPlatingMovies.sublist(0,4);

});