
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/providers/widgets/widgets.dart';
import 'package:flutter/material.dart';
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
  }

  @override
  Widget build(BuildContext context) {

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch( moviesSlideShowProvider );

    return Column(
      children: [
        const CustomAppbar(),

        MoviesSlidehow(movies: slideShowMovies ),
        MovieHorizontalListview(
          movies: nowPlayingMovies,
          title:  'En Cines',
          subTitle: 'Lunes 20',)

      ],
    );
  }
}
