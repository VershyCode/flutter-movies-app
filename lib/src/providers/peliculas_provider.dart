import 'dart:convert';

import 'package:movies_app/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;
class PeliculasProvider {
  String _apikey    = 'fc5bc8e39511743e51140d155c104b32';
  String _url       = 'api.themoviedb.org';
  String _language  = 'es-ES';

  Future<List<Pelicula>> getEnCines() async {
    /// Con [Uri] construimos la url, @param1 = url @param2 = endpoint @param3 = map with new query params.
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key'   : _apikey,
      'language'  : _language
    });
    final response = await http.get(url); /// [response] = respuesta de la API.
    final decodedData = json.decode(response.body); /// Convertimos la respuesta a un json.
    final peliculas = new Peliculas.fromJsonList(decodedData['results']); /// [peliculas] = lista de peliculas desde el modelo.

    return peliculas.items;
  }

  Future<List<Pelicula>> getPopulares() async {
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key'   : _apikey,
      'language'  : _language
    });
    final response = await http.get(url);
    final respDecoded = json.decode(response.body);
    final peliculasPopulares = new Peliculas.fromJsonList(respDecoded['results']);
    
    return peliculasPopulares.items;
  }
}