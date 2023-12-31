

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart';
// R I V E R P O D

final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) { // "StateNotifierProvider"proveedor de estado que notifica su cambio
  
  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getNowPlaying;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) { // "StateNotifierProvider"proveedor de estado que notifica su cambio
  
  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getPopular;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

final upComingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) { // "StateNotifierProvider"proveedor de estado que notifica su cambio
  
  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getUpcoming;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) { // "StateNotifierProvider"proveedor de estado que notifica su cambio
  
  final fetchMoreMovies = ref.watch( movieRepositoryProvider ).getTopRated;

  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

// Para mantener un estado de peliculas. Se puede usar para saber cuales son las peliculas que se estan usando
typedef MovieCallback = Future<List<Movie>> Function({ int page });

class MoviesNotifier extends StateNotifier<List<Movie>> {

  int currentPage = 0;
  bool isLoading = false;
  MovieCallback fetchMoreMovies;

  MoviesNotifier({
    required this.fetchMoreMovies
  }): super([]);
  //Mètodo para cargar la siguiente pàgina de peliculas y mantenerlas en memoria 
  Future<void> loadNextPage() async{
    if ( isLoading ) return;
    
    isLoading = true;
    print('loading more movies ');
    currentPage++;

    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;

  }
}