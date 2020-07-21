import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CardSwiper extends StatelessWidget {
  final List<dynamic> peliculas;
  CardSwiper({ @required this.peliculas });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
          itemBuilder: (BuildContext context, int index){
            return  ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.network("http://via.placeholder.com/350x150",fit: BoxFit.cover),
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