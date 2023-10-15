import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});


  Stream<String> getLoadingMessages(){
  final messages = <String>[
    'Cargando Peliculas',
    'Comprando palomitas de maiz',
    'Cargando Populares',
    'Llamando a mi novia',
    'Cargando Esto esta demorando mas de lo esperado :(',
  ];

    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('Espere por favor'),
          const SizedBox(height: 10),
          const CircularProgressIndicator(),
          const SizedBox(height: 10),

          StreamBuilder(
            stream: getLoadingMessages(), 
            builder: (context, snapshot) {
              if ( !snapshot.hasData ) return const Text('Cargando...');
              return Text( snapshot.data! );
            },)
        ],
      ),
    );
  }
}