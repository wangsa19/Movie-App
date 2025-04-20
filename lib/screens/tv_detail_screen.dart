import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/constant/style.dart';
import 'package:movie_app/model/hive_tv_model.dart';
import 'package:movie_app/model/tv/tv_model.dart';
import 'package:movie_app/screens/reviews.dart';
import 'package:movie_app/screens/trailers_screen.dart';
import 'package:movie_app/tv_widgets/similar_tv_widget.dart';
import 'package:movie_app/tv_widgets/tv_info.dart';

class TvDetailScreen extends StatefulWidget {
  const TvDetailScreen({super.key, required this.tvShows, this.request});
  final TVShows tvShows;
  final String? request;

  @override
  State<TvDetailScreen> createState() => _TvDetailScreenState();
}

class _TvDetailScreenState extends State<TvDetailScreen> {
  late Box<HiveTVModel> _tvWatchLists;
  @override
  void initState() {
    _tvWatchLists = Hive.box<HiveTVModel>('tv_lists');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tvShows.name!, overflow: TextOverflow.ellipsis),
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
                            ? "${widget.tvShows.id}"
                            : "${widget.tvShows.id}+${widget.request!}",
                    child: _buildPoster(),
                  ),
                ),
              ],
            ),
            TVsInfo(id: widget.tvShows.id!),
            SimilarTvWidget(id: widget.tvShows.id!),
            Reviews(id: widget.tvShows.id!, request: "tv"),
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
                              id: widget.tvShows.id!,
                              show: "tv",
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
                    HiveTVModel newValue = HiveTVModel(
                      id: widget.tvShows.id!,
                      rating: widget.tvShows.rating!,
                      name: widget.tvShows.name!,
                      backDrop: widget.tvShows.backDrop!,
                      poster: widget.tvShows.poster!,
                      overview: widget.tvShows.overview!,
                    );
                    _tvWatchLists.add(newValue);
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
    if (widget.tvShows.backDrop == null) {
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
            "https://image.tmdb.org/t/p/original${widget.tvShows.backDrop}",
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildBackDrop() {
    if (widget.tvShows.backDrop == null) {
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
            "https://image.tmdb.org/t/p/original${widget.tvShows.backDrop}",
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
            "${widget.tvShows.name!} successfully added to watch list.",
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
