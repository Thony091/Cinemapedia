// ocupa libreria card_swiper -> deslizar imagenes
// libreria animate_do -> para animacion 

import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MoviesSlidehow extends StatelessWidget {

  final List<Movie> movies;

  const MoviesSlidehow({super.key, 
  required this.movies}
  );
  @override 
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 210,
      width: double.infinity, //tomar todo el ancho posible "double.infinity"
      child: Swiper(
        
        viewportFraction: 0.85, //adaptar el item a lo especificado, (porcentaje = 80% => 0.8)
        scale: 0.9, //separaciòn entre items(peliculas)
        autoplay: true, //se mueva de forma automatica
        pagination: SwiperPagination( //paginador (puntos)
          margin:  const EdgeInsets.only(top: 0), //posicion solo para rriba, 
          builder: DotSwiperPaginationBuilder( //pide configuraciones para construir
            activeColor: colors.primary,
            color: colors.secondary
          )
        ),
        itemCount: movies.length, //cantidad de items dentro del swiper
        itemBuilder: (context, index) => _Slide(movie: movies[index] //constructor de items 
        ),         
      ),
    );
  }
}

class _Slide extends StatelessWidget {

  final Movie movie;

  const _Slide({super.key, 
  required this.movie});

  @override
  Widget build(BuildContext context) {
    
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [ 
        BoxShadow( 
          color: Colors.black45,
          blurRadius: 10,
          offset: Offset(0, 10)
        )
      ]
    );

    return  Padding(
      padding: const EdgeInsets.only(bottom: 30), 
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect( //"ClippRRect permite redondear bordes"
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            movie.backdropPath, 
            
            fit: BoxFit.cover, //adaptar a "cuerpo"
            loadingBuilder: (context, child, loadingProgress) {
              if( loadingProgress != null ){
                return const DecoratedBox(
                  decoration: BoxDecoration(color:  Colors.black12)
                );
              }
              return FadeIn(child: child) ; //imagenes se visualizan de forma suave al cargarse en memoria
            },             
          )
        )
      ),
     );
  }
}