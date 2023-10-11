import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {

  static const name = 'home-screen<';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: _HomeView()
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
    ref.read( nowPlayingMoviesProvider.notifier ).loadNextPage() ; //Puente
  }

  @override
  Widget build(BuildContext context) {

    final nowPlatingMovies = ref.watch( nowPlayingMoviesProvider) ;
    if (nowPlatingMovies.length == 0 ) return CircularProgressIndicator();
    
    return ListView.builder(
      itemCount: nowPlatingMovies.length,
      itemBuilder: (context, index) {
        final movie = nowPlatingMovies[index];
        return ListTile(
          title: Text( movie.title ),
        );
      },

    );
  }
}