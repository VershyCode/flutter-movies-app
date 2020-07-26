import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies_app/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Pelicula> peliculas;
  CardSwiper({ @required this.peliculas });

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size; // Obtenemos el size de la pantalla del dispositivo.

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
          itemBuilder: (BuildContext context, int index){
            peliculas[index].uniqueId = '${peliculas[index].id}-tarjeta';
            return  Hero(
              tag: peliculas[index].uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]);
                  },
                  child: FadeInImage(
                    image: NetworkImage(peliculas[index].getPostImg()), /// [index] es la posicion de la pelicula en [peliculas].
                    placeholder: AssetImage('assets/loading.gif'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
          itemCount: peliculas.length,
          itemWidth: _screenSize.width * 0.7, // 70% del ancho del telefono.
          itemHeight: _screenSize.height * 0.5, // 50% del alto del telefono.
          layout: SwiperLayout.STACK,
        ),
    );
  }
}