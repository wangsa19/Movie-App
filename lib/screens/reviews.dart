import 'package:flutter/material.dart';
import 'package:movie_app/constant/style.dart';
import 'package:movie_app/http/http_request.dart';
import 'package:movie_app/model/reviews_model.dart';

class Reviews extends StatefulWidget {
  const Reviews({super.key, required this.id, required this.request});
  final int id;
  final String request;

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 20),
            child: Text(
              'SIMILAR MOVIES',
              style: TextStyle(
                color: Style.textColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          FutureBuilder<ReviewsModel>(
            future: HttpRequest.getReviews(widget.request, widget.id),
            builder: (context, AsyncSnapshot<ReviewsModel> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.error != null &&
                    snapshot.data!.error!.isNotEmpty) {
                  return _buildErrorWidget(snapshot.data!.error);
                }
                return _buildReviewsWidget(snapshot.data!);
              } else if (snapshot.hasError) {
                return _buildErrorWidget(snapshot.error.toString());
              } else {
                return _buildLoadingWidget();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[
          SizedBox(
            width: 25,
            height: 25,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(dynamic error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Something went wrong : $error',
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsWidget(ReviewsModel data) {
    List<Review>? reviews = data.reviews;
    if (reviews == null || reviews.isEmpty) {
      return const SizedBox(
        child: Center(
          child: Text(
            "These is no reviews shown",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      );
    } else {
      return Column(
        children: List.generate(reviews.length, (index) {
          return Card(
            color: Style.textColor,
            margin: const EdgeInsets.symmetric(vertical: 10),
            elevation: 5,
            child: ListTile(
              title: Text(
                reviews[index].content!,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }),
      );
    }
  }
}
