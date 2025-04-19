// ignore_for_file: public_member_api_docs, sort_constructors_first
class MovieModel {
  final List<Movie> ? movies;
  final String? error;

  MovieModel({this.movies, this.error});

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
    movies: json['results'] != null
        ? (json['results'] as List).map((i) => Movie.fromJson(i)).toList()
        : null,
    error: "",
  );

  factory MovieModel.withError(String error) => MovieModel(
    movies: [],
    error: error,
  );
}

class Movie {
  int? id;
  double? rating;
  String? title;
  String? backDrop;
  String? poster;
  String? overview;

  Movie({
    this.id,
    this.rating,
    this.title,
    this.backDrop,
    this.poster,
    this.overview,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    id: json['id'],
    rating: json['vote_average'] != null ? (json['vote_average'] as num).toDouble() : 0.0,
    title: json['title'],
    backDrop: json['backdrop_path'],
    poster: json['poster_path'],
    overview: json['overview'],
  );
}
