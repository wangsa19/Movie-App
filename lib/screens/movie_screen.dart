import 'package:flutter/material.dart';
import 'package:movie_app/movie_widgets/get_genres.dart';
import 'package:movie_app/movie_widgets/now_playing_widget.dart';
import 'package:movie_app/movie_widgets/movies_widget.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        NowPlaying(),
        GetGenres(),
        MoviesWidget(title: 'UPCOMING', request: 'upcoming',),
        MoviesWidget(title: 'POPULAR', request: 'popular',),
        MoviesWidget(title: 'TOP RATED', request: 'top_rated',),
      ],
    );
  }
}
