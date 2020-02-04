import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class CardSwipperWidget extends StatelessWidget {
  final List<Pelicula> peliculas;

  CardSwipperWidget({@required this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        itemWidth: _screenSize.width * 0.6,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          peliculas[index].uniqueId = '${peliculas[index].id}-tarjeta';
          return Hero(
            tag: peliculas[index].uniqueId,
            child: GestureDetector(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    peliculas[index].getPosterImg(),
                  ),
                ),
              ),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  'detalle',
                  arguments: peliculas[index],
                );
              },
            ),
          );
        },
        itemCount: peliculas.length,
        layout: SwiperLayout.STACK,
        // pagination: SwiperPagination(),
        // control: SwiperControl(),
      ),
    );
  }
}
