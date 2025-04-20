import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/constant/style.dart';
import 'package:movie_app/http/http_request.dart';
import 'package:movie_app/model/movie/movie_model.dart';
import 'package:movie_app/screens/movie_detail_screen.dart';

class SimilarMovie extends StatefulWidget {
  const SimilarMovie({super.key, required this.id});
  final int id;

  @override
  State<SimilarMovie> createState() => _SimilarMovieState();
}

class _SimilarMovieState extends State<SimilarMovie> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
        FutureBuilder<MovieModel>(
          future: HttpRequest.getSimilarMovie(widget.id),
          builder: (context, AsyncSnapshot<MovieModel> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.error != null &&
                  snapshot.data!.error!.isNotEmpty) {
                return _buildErrorWidget(snapshot.data!.error);
              }
              return _buildSimilarMoviesWidget(snapshot.data!);
            } else if (snapshot.hasError) {
              return _buildErrorWidget(snapshot.error.toString());
            } else {
              return _buildLoadingWidget();
            }
          },
        ),
      ],
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

  Widget _buildSimilarMoviesWidget(MovieModel data) {
    List<Movie>? movies = data.movies;
    if (movies!.isEmpty) {
      return const SizedBox(
        child: Text(
          'No Movies Found',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      );
    } else {
      return Container(
        height: 270,
        padding: const EdgeInsets.only(left: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          (_) => MovieDetailScreen(
                            movie: movies[index],
                          ),
                    ),
                  );
                },
                child: Column(
                  children: <Widget>[
                    movies[index].poster == null
                        ? Container(
                          width: 120,
                          height: 180,
                          decoration: const BoxDecoration(
                            color: Style.secondaryColor,
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            shape: BoxShape.rectangle,
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.videocam_off,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                        )
                        : Hero(
                          tag: "${movies[index].id}",
                          child: Container(
                            width: 120,
                            height: 180,
                            decoration: BoxDecoration(
                              color: Style.secondaryColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(2),
                              ),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://image.tmdb.org/t/p/w200/${movies[index].poster!}",
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 100,
                      child: Text(
                        movies[index].title!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          height: 1.4,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Text(
                          movies[index].rating.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    RatingBar.builder(
                      itemSize: 8,
                      initialRating: movies[index].rating! / 2,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 2),
                      itemBuilder:
                          (context, _) => const Icon(
                            Icons.star,
                            color: Style.secondaryColor,
                          ),
                      onRatingUpdate: (rating) {},
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }
}
