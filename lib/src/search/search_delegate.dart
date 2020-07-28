import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {

  String selected = '';
  final peliculas = [
    'Aquaman',
    'Parasitos',
    'Scooby-Doo',
    'The rental',
    'The outpost',
    'Becky',
    'Onward',
    'Iron man 1',
    'Iron man 2',
    'Iron man 3',
    'Iron man 4'
  ];

  final peliculasRecientes = [
    'Spiderman',
    'Capitan America',
    'Greyhound'
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones de nuestro AppBar.
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono ala izquierda del AppBar.
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar.
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(selected),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen al escribir.
    final listaSugerida = ( query.isEmpty ) 
                          ? peliculasRecientes 
                          : peliculas.where(
                            (p) => p.toLowerCase().startsWith(query.toLowerCase())
                          ).toList();
    /// Si el query esta vacio: mostraremos sugerencias [peliculasRecientes].
    /// Si el query tiene texto: Entonces le asignamos a [listaSugerida] una nueva lista
    /// la cual contendra los elementos de [peliculas] que comiencen con el texto que recibe el query. 
    return ListView.builder(
      itemCount: listaSugerida.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaSugerida[i]),
          onTap: (){
            selected = listaSugerida[i];
            showResults(context);
          },
        );
      }
    );
  }
  
}