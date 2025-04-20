// ignore_for_file: public_member_api_docs, sort_constructors_first
class ReviewsModel {
  final List<Review> ? reviews;
  final String? error;

  ReviewsModel({this.reviews, this.error});

  factory ReviewsModel.fromJson(Map<String, dynamic> json) => ReviewsModel(
    reviews: json['reviews'] != null
        ? (json['reviews'] as List).map((i) => Review.fromJson(i)).toList()
        : null,
    error: "",
  );

  factory ReviewsModel.withError(String error) => ReviewsModel(
    reviews: [],
    error: error,
  );
}

class Review {
  int? id;
  String? author;
  String? content;

  Review({
    this.id,
    this.author,
    this.content,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json['id'],
    author: json['author'],
    content: json['content'],
  );
}
