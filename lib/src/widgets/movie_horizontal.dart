import 'package:flutter/material.dart';
import 'package:movies_app/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final _pageController = new PageController(initialPage: 1, viewportFraction: 0.3);
  final Function siguientePagina; // Callback para nuestro addListener.
  MovieHorizontal({ @required this.peliculas, @required this.siguientePagina });

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      // Si los pixels son igual al maxScroll - 200, entonces llamar a siguientepagina.
      if(_pageController.position.pixels > _pageController.position.maxScrollExtent - 200){
        siguientePagina(); // callback.
      }
    });

    return Container(
      height: _screenSize.height * 0.2, // 20%
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        itemBuilder: (BuildContext context, i){
          return _tarjeta(context, peliculas[i]);
        },
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula){
    pelicula.uniqueId = '${pelicula.id}-poster';
   final tarjeta = Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            Hero(
              tag: pelicula.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: FadeInImage(
                  image: NetworkImage(pelicula.getPostImg()),
                  placeholder: AssetImage('assets/loading.gif'),
                  fit: BoxFit.cover,
                  height: 100.0,
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
      ); 
      return GestureDetector(
        child: tarjeta,
        onTap: (){
          Navigator.pushNamed(context, 'detalle', arguments: pelicula);
        },
      );
  }
}