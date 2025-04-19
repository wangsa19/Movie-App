// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:movie_app/model/genre_model.dart';

class TvDetailsModel {
  final TVDetails? details;
  final String? error;

  TvDetailsModel({this.details, this.error});

  factory TvDetailsModel.fromJson(Map<String, dynamic> json) => TvDetailsModel(
    details: TVDetails.fromJson(json),
    error: "",
  );

  factory TvDetailsModel.withError(String error) => TvDetailsModel(
    details: TVDetails(),
    error: error,
  );
}

class TVDetails {
  int? id;
  List<Genre>? genres;
  String? firstAirDate;
  String? overview;
  String? backDrop;
  String? poster;
  double? rating;
  String? name;
  int? numberOfEpisodes;
  int? numberOfSeasons;

  TVDetails({
    this.id,
    this.genres,
    this.firstAirDate,
    this.overview,
    this.backDrop,
    this.poster,
    this.rating,
    this.name,
    this.numberOfEpisodes,
    this.numberOfSeasons,
  });

  factory TVDetails.fromJson(Map<String, dynamic> json) => TVDetails(
    id: json['id'],
    genres: json['genres'] != null
        ? (json['genres'] as List).map((i) => Genre.fromJson(i)).toList()
        : null,
    firstAirDate: json['first_air_date'],
    overview: json['overview'],
    backDrop: json['backdrop_path'],
    poster: json['poster_path'],
    rating: json['vote_average'] != null ? (json['vote_average'] as num).toDouble() : 0.0,
    name: json['name'],
    numberOfEpisodes: json['number_of_episodes'],
    numberOfSeasons: json['number_of_seasons'],
  );
}

