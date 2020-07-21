class Peliculas{
  List<Pelicula> items = new List();

  Peliculas();

  Peliculas.fromJsonList(List<dynamic> jsonList){
    /// [jsonList] = "results" (Resultados que envio la API). 
    if(jsonList == null) return;
    for(var item in jsonList){
      /// [item] = cada objeto que recibimos dentro de "results".
      final pelicula = new Pelicula.fromJsonMap(item);
      /// [pelicula] = Una instancia de pelicula con los datos mapeados de cada pelicula recibida.
      items.add(pelicula);
      /// Agregamos la pelicula a la lista de peliculas.
    }
  }
}

class Pelicula {
  double popularity;
  int voteCount;
  bool video;
  String posterPath;
  int id;
  bool adult;
  String backdropPath;
  String originalLanguage;
  String originalTitle;
  List<int> genreIds;
  String title;
  double voteAverage;
  String overview;
  String releaseDate;

  Pelicula({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
  });

  Pelicula.fromJsonMap(Map<String, dynamic> json){
    
    popularity        = json['popularity'] / 1; // Si llega como int lo transformamos a double.
    voteCount         = json['vote_count'];
    video             = json['video'];
    posterPath        = json['poster_path'];
    id                = json['id'];
    adult             = json['adult'];
    backdropPath      = json['backdrop_path'];
    originalLanguage  = json['original_language'];
    originalTitle     = json['original_title'];
    genreIds          = json['genre_ids'].cast<int>(); // Casteamos lo que venga a un int.
    title             = json['title'];
    voteAverage       = json['vote_average'] / 1; 
    overview          = json['overview'];
    releaseDate       = json['release_date'];

  }
}
