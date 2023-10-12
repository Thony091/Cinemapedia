import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';

class MovieHorizontalListview extends StatelessWidget {

  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListview({super.key, 
  required this.movies, 
  this.title, 
  this.subTitle, 
  this.loadNextPage});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          
          if(title != null || subTitle == null)
          _Title(title: title, subtitle: subTitle,),

          Expanded(
            //elegir "ListView.builder" para construir muchos widgets
            child: ListView.builder(
              itemCount: movies.length,
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _Slide(movie: movies[index]);           
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

    final textStyle = Theme.of(context).textTheme;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
                width: 150,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null){
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
                    );
                  }
                  return FadeIn(child: child);
                },
              ),
            ),
          ),

          SizedBox(height: 5,),
          //* Title
          SizedBox(
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