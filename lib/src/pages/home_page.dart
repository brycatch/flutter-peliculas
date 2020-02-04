import 'package:flutter/material.dart';
import 'package:peliculas/src/search/search_delegate.dart';

import 'package:peliculas/src/widgets/card_swipper_widget.dart';
import 'package:peliculas/src/providers/pelicula_provider.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculaProvider();

  @override
  Widget build(BuildContext context) {
    peliculasProvider.getPopular();

    return Scaffold(
      appBar: AppBar(
        title: Text('Películas en cines'),
        centerTitle: false,
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: DataSearchDelegate(),
                query: '',
              );
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swipperTarjetas(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swipperTarjetas() {
    return FutureBuilder(
      future: peliculasProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        return snapshot.hasData
            ? CardSwipperWidget(peliculas: snapshot.data)
            : Container(
                height: 400.0,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Populares',
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              return snapshot.hasData
                  ? MovieHorizontalWidget(
                      peliculas: snapshot.data,
                      siguientePagina: peliculasProvider.getPopular,
                    )
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
