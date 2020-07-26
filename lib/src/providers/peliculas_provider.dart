import 'dart:async';
import 'dart:convert';
import 'package:movies_app/src/models/actores_model.dart';
import 'package:movies_app/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider {
  String _apikey    = 'fc5bc8e39511743e51140d155c104b32';
  String _url       = 'api.themoviedb.org';
  String _language  = 'es-ES';
  int _popularesPage = 0;
  bool _cargando = false;
  List<Pelicula> _populares = new List();
  final _popularesStreamController = new StreamController<List<Pelicula>>.broadcast();

  // Getters
  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;
  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;


  void disposeStreams(){
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final response = await http.get(url); /// [response] = respuesta de la API.
    final decodedData = json.decode(response.body); /// Convertimos la respuesta a un json.
    final peliculas = new Peliculas.fromJsonList(decodedData['results']); /// [peliculas] = lista de peliculas desde el modelo.

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    /// Con [Uri] construimos la url, @param1 = url @param2 = endpoint @param3 = map with new query params.
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key'   : _apikey,
      'language'  : _language
    });
    
    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if(_cargando) return []; // Si esta cargando regresamos [].
    _cargando = true; // Si no esta cargando.
    _popularesPage++; //  Aumentamos la pagina en 1.
    final url = Uri.https(_url, '3/movie/popular', { // Construimos la url.
      'api_key'   : _apikey,
      'language'  : _language,
      'page'      : _popularesPage.toString()
    });
    final resp = await _procesarRespuesta(url); // Procesamos la request.
    _populares.addAll(resp); // Agregamos todo ala lista de peliculas.
    popularesSink( _populares ); // Agregamos al stream la lista de peliculas.
    _cargando = false; // Dejamos de cargar
    return resp; // Regresamos la respuesta.
  }

  Future<List<Actor>> _getCast(String peliId) async{
    final url = Uri.https(_url, '3/movie/$peliId/credits', {
      'api_key': _apikey,
      'language': _language
    });
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final cast = new Cast.fromJsonList(decodedData['cast']);
    return cast.actores;
  }
}