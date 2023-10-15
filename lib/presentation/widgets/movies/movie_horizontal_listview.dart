import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListview extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview({super.key, 
  required this.movies, 
  this.title, 
  this.subTitle, 
  this.loadNextPage
  });

  @override
  State<MovieHorizontalListview> createState() => _MovieHorizontalListviewState();
}

class _MovieHorizontalListviewState extends State<MovieHorizontalListview> {

  final scrollController = ScrollController(); // PAra poder controlar el scroller

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() { // para agregarlo a la "lista de escuchados"
      if(widget.loadNextPage == null )return;

      if( scrollController.position.pixels + 200 >= scrollController.position.maxScrollExtent ){
        print('Load next movies');
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() { //para destruir el addListener cuando se haya terminado
    // TODO: implement dispose
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          
          if(widget.title != null || widget.subTitle == null)
          _Title(title: widget.title, subtitle: widget.subTitle,),

          Expanded(
            //elegir "ListView.builder" para construir muchos widgets
            child: ListView.builder(
              controller: scrollController,
              itemCount: widget.movies.length,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return FadeInRight(child: _Slide(movie: widget.movies[index]));           
              }
            ,)
          )
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  
  final Movie movie;
  const _Slide({
    super.key, 
    required this.movie}
  );


  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme;//obtenciòn lo todos los temas de textos

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8), //margen para ambos lados(horizontal) de 8 px (separaciòn de widgets)
      child: Column( //Columna con varios widgets(horizontal), alineamiento al princio de espacio(izquierda)
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox( // Caja de 150 px de ancho, aplicando a los widgets internos redondeo (ClipRRect)
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network( // solicitud de imagen de la web ("movie.posterPath" consumo del API) con ancho de 150 px con adaptaciòn al "cuerpo"
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null){
                    return const Padding( //padding que da espacio de 8 px al circulo de progreso de carga con grosor de 2 px
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                    );
                  }
                  return FadeIn(child: child);
                },
              ),
            ),
          ),

          const SizedBox(height: 5,),
          //* Title
          SizedBox( // caja con ancho 150 px, maximo de 2 lineas permitidas y estilo pequeño de fuente de letras 
            width: 150,
            child: Text(
              movie.title,
              maxLines: 2,
              style: textStyle.titleSmall,
            ),
          ),
          //* Ratting
          Row(
            children: [
              Icon(Icons.star_half_outlined, color:  Colors.yellow.shade800,),
              const SizedBox(width: 3),
              Text('${ movie.voteAverage }', style: textStyle.bodyMedium?.copyWith(),),// ".copyWith" permite copiar toda la informacion de api
              const SizedBox(width: 10),
              Text(HumanFormats.number( movie.popularity ) , style: textStyle.bodySmall,),


            ],
          )
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {

  final String? title;
  final String? subtitle;
  
  const _Title({
    super.key, 
    this.title, 
    this.subtitle}
  );

  @override
  Widget build(BuildContext context) {

    final titleStyle = Theme.of(context).textTheme.titleLarge;

    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [

          if( title != null )
          Text( title!, style: titleStyle,),

           const Spacer(),

          if( subtitle != null )
          FilledButton.tonal( //para configurar un boton
            style: const ButtonStyle( visualDensity: VisualDensity.compact), // compacta a la vista el boton
            onPressed:() { },
            child: Text( subtitle!)
          ),

        ],
      ),
    );
  }
}