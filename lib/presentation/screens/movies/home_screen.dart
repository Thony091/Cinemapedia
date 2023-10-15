import 'package:flutter/material.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomeScreen extends StatelessWidget {
  static const name = 'home-screen<';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(), //Cuerpo
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView({
    super.key,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ref.read( nowPlayingMoviesProvider.notifier ).loadNextPage(); //Puente
    ref.read( popularMoviesProvider.notifier ).loadNextPage(); //Puente
    ref.read( upComingMoviesProvider.notifier ).loadNextPage(); //Puente
    ref.read( topRatedMoviesProvider.notifier ).loadNextPage(); //Puente
  }

  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch( initialLoadingProvider );
    if ( initialLoading )return const FullScreenLoader();

    final slideShowMovies   = ref.watch( moviesSlideShowProvider );
    final nowPlayingMovies  = ref.watch(nowPlayingMoviesProvider);
    final popularMovies     = ref.watch(popularMoviesProvider);
    final upComingMovies    = ref.watch(upComingMoviesProvider);
    final topRatedMovies    = ref.watch(topRatedMoviesProvider);


    return CustomScrollView( //Para trabajar con sliver y scroll
      slivers: [
        const SliverAppBar( //barra Appbar de sliver
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title:  CustomAppbar(),   //appBar customisado
          ),
        ),

        SliverList( // para crear lista de slivers
          delegate: SliverChildBuilderDelegate(  
            (context, index) {
              return Column(
                children: [
                  // const CustomAppbar(),
            
                  MoviesSlidehow(movies: slideShowMovies ),
                  
                  MovieHorizontalListview(
                    movies: nowPlayingMovies,
                    title:  'En Cines',
                    subTitle: 'Lunes 20',
                    loadNextPage: () {
                      ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                    },
                  ),
            
                  MovieHorizontalListview(
                    movies: upComingMovies,
                    title:  'Proximamente',
                    subTitle: 'En este mes',
                    loadNextPage: () {
                      ref.read(upComingMoviesProvider.notifier).loadNextPage();
                    },
                  ),
                  MovieHorizontalListview(
                    movies: popularMovies,
                    title:  'Populares',
                    // subTitle: 'En este mes',
                    loadNextPage: () {
                      ref.read(popularMoviesProvider.notifier).loadNextPage();
                    },
                  ),
                  MovieHorizontalListview(
                    movies: topRatedMovies,
                    title:  'Top Rated',
                    // subTitle: 'En este mes',
                    loadNextPage: () {
                      ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                    },
                  ),
                  const SizedBox(height: 10,)
            
            
                ],
              );
            }
          )
        )
      ]
    );
  }
}


