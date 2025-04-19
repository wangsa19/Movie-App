// ignore_for_file: public_member_api_docs, sort_constructors_first
class GenreModel {
  final List<Genre>? genres;
  final String? error;

  GenreModel({this.genres, this.error});

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
    genres:
        json['genres'] != null
            ? (json['genres'] as List).map((i) => Genre.fromJson(i)).toList()
            : null,

    error: "",
  );

  factory GenreModel.withError(String error) =>
      GenreModel(genres: [], error: error);
}

class Genre {
  int? id;
  String? name;

  Genre({this.id, this.name});

  factory Genre.fromJson(Map<String, dynamic> json) =>
      Genre(id: json['id'], name: json['name']);
}
