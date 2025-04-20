import 'package:flutter/material.dart';
import 'package:movie_app/tv_widgets/airing_today_widget.dart';
import 'package:movie_app/tv_widgets/get_genres.dart';
import 'package:movie_app/tv_widgets/tv_widget.dart';

class TvScreen extends StatefulWidget {
  const TvScreen({super.key});

  @override
  State<TvScreen> createState() => _TvScreenState();
}

class _TvScreenState extends State<TvScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        AiringTodayWidget(),
        GetGenres(),
        TVsWidget(title: "UPCOMING", request: "on_the_air"),
        TVsWidget(title: "POPULAR", request: "popular"),
        TVsWidget(title: "TOP RATED", request: "top_rated"),
      ],
    );
  }
}
