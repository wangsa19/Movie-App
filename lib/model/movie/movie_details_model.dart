// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movie_app/model/genre_model.dart';

class MovieDetailsModel {
  final MovieDetails? details;
  final String? error;

  MovieDetailsModel({this.details, this.error});

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) => MovieDetailsModel(
    details: MovieDetails.fromJson(json),
    error: "",
  );

  factory MovieDetailsModel.withError(String error) => MovieDetailsModel(
    details: MovieDetails(),
    error: error,
  );
}

class MovieDetails {
  int? id;
  List<Genre>? genres;
  String? releaseDate;
  String? overview;
  String? backDrop;
  String? poster;
  double? rating;
  String? title;
  int? runtime;

  MovieDetails({
    this.id,
    this.genres,
    this.releaseDate,
    this.overview,
    this.backDrop,
    this.poster,
    this.rating,
    this.title,
    this.runtime,
  });

  factory MovieDetails.fromJson(Map<String, dynamic> json) => MovieDetails(
    id: json['id'],
    genres: json['genres'] != null
        ? (json['genres'] as List).map((i) => Genre.fromJson(i)).toList()
        : null,
    releaseDate: json['release_date'],
    overview: json['overview'],
    backDrop: json['backdrop_path'],
    poster: json['poster_path'],
    rating: json['vote_average'] != null ? (json['vote_average'] as num).toDouble() : 0.0,
    title: json['title'],
    runtime: json['runtime'],
  );
}

