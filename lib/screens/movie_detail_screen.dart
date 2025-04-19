import 'package:flutter/material.dart';
import 'package:movie_app/model/movie/movie_model.dart';
import 'package:movie_app/movie_widgets/movie_info.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({
    super.key,
    required this.movie,
    required this.request,
  });
  final Movie movie;
  final String? request;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title!, overflow: TextOverflow.ellipsis),
      ),
      body: Column(
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
        ],
      ),
    );
  }

  Widget _buildPoster() {
    return Container(
      width: 120,
      height: 180,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          image: NetworkImage(
            "https://image.tmdb.org/t/p/original${widget.movie.backDrop!}",
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildBackDrop() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          image: NetworkImage(
            "https://image.tmdb.org/t/p/original${widget.movie.backDrop!}",
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
