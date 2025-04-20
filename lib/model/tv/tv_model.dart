// ignore_for_file: public_member_api_docs, sort_constructors_first
class TVModel {
  final List<TVShows> ? tvShows;
  final String? error;

  TVModel({this.tvShows, this.error});

  factory TVModel.fromJson(Map<String, dynamic> json) => TVModel(
    tvShows: json['results'] != null
        ? (json['results'] as List).map((i) => TVShows.fromJson(i)).toList()
        : null,
    error: "",
  );

  factory TVModel.withError(String error) => TVModel(
    tvShows: [],
    error: error,
  );
}

class TVShows {
  int? id;
  double? rating;
  String? name;
  String? backDrop;
  String? poster;
  String? overview;

  TVShows({
    this.id,
    this.rating,
    this.name,
    this.backDrop,
    this.poster,
    this.overview,
  });

  factory TVShows.fromJson(Map<String, dynamic> json) => TVShows(
    id: json['id'],
    rating: json['vote_average'] != null ? (json['vote_average'] as num).toDouble() : 0.0,
    name: json['name'],
    backDrop: json['backdrop_path'],
    poster: json['poster_path'],
    overview: json['overview'],
  );
}
