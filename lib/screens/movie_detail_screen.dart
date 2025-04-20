import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/constant/style.dart';
import 'package:movie_app/model/hive_movie_model.dart';
import 'package:movie_app/model/movie/movie_model.dart';
import 'package:movie_app/movie_widgets/movie_info.dart';
import 'package:movie_app/movie_widgets/similar_movie.dart';
import 'package:movie_app/screens/reviews.dart';
import 'package:movie_app/screens/trailers_screen.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.movie, this.request});
  final Movie movie;
  final String? request;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late Box<HiveMovieModel> _movieWatchLists;
  @override
  void initState() {
    _movieWatchLists = Hive.box<HiveMovieModel>('movie_lists');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title!, overflow: TextOverflow.ellipsis),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: [
                _buildBackDrop(),
                Positioned(
                  top: 150,
                  left: 30,
                  child: Hero(
                    tag:
                        widget.request == null
                            ? "${widget.movie.id}"
                            : "${widget.movie.id}+${widget.request!}",
                    child: _buildPoster(),
                  ),
                ),
              ],
            ),
            MovieInfo(id: widget.movie.id!),
            SimilarMovie(id: widget.movie.id!),
            Reviews(id: widget.movie.id!, request: "movie"),
          ],
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                color: Colors.redAccent,
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder:
                            (_) => TrailersScreen(
                              id: widget.movie.id!,
                              show: "movie",
                            ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.play_circle_fill_rounded,
                    size: 30,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Watch Trailer',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Style.secondaryColor,
                child: TextButton.icon(
                  onPressed: () {
                    HiveMovieModel newValue = HiveMovieModel(
                      id: widget.movie.id!,
                      rating: widget.movie.rating!,
                      title: widget.movie.title!,
                      backDrop: widget.movie.backDrop!,
                      poster: widget.movie.poster!,
                      overview: widget.movie.overview!,
                    );
                    _movieWatchLists.add(newValue);
                    _showAlertDialog();
                  },
                  icon: const Icon(
                    Icons.list_alt_outlined,
                    size: 30,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Add To List',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPoster() {
    if (widget.movie.backDrop == null) {
      return Container(
        width: 120,
        height: 180,
        color: Colors.grey[800],
        alignment: Alignment.center,
        child: const Text("No Poster", style: TextStyle(color: Colors.white)),
      );
    }

    return Container(
      width: 120,
      height: 180,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          image: NetworkImage(
            "https://image.tmdb.org/t/p/original${widget.movie.backDrop}",
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildBackDrop() {
    if (widget.movie.backDrop == null) {
      return Container(
        height: 200,
        color: Colors.grey[800],
        alignment: Alignment.center,
        child: const Text(
          "No Backdrop Available",
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return Container(
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          image: NetworkImage(
            "https://image.tmdb.org/t/p/original${widget.movie.backDrop}",
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Added to List"),
          content: Text(
            "${widget.movie.title!} successfully added to watch list.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
