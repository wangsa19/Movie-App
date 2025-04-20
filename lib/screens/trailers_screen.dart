import 'package:flutter/material.dart';
import 'package:movie_app/http/http_request.dart';
import 'package:movie_app/model/trailers_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrailersScreen extends StatefulWidget {
  const TrailersScreen({super.key, required this.show, required this.id});
  final String show;
  final int id;

  @override
  State<TrailersScreen> createState() => _TrailersScreenState();
}

class _TrailersScreenState extends State<TrailersScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TrailersModel>(
      future: HttpRequest.getTrailers(widget.show, widget.id),
      builder: (context, AsyncSnapshot<TrailersModel> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.error != null &&
              snapshot.data!.error!.isNotEmpty) {
            return _buildErrorWidget(snapshot.data!.error);
          }
          return _buildTrailersWidget(snapshot.data!);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error.toString());
        } else {
          return _buildLoadingWidget();
        }
      },
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

  Widget _buildTrailersWidget(TrailersModel data) {
    List<Video>? videos = data.trailers;
    return Container(
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          Center(
            child:
                (videos != null && videos.isNotEmpty && videos[0].key != null)
                    ? YoutubePlayer(
                      controller: YoutubePlayerController(
                        initialVideoId: videos[0].key!,
                        flags: const YoutubePlayerFlags(
                          hideControls: true,
                          autoPlay: true,
                        ),
                      ),
                    )
                    : const Text(
                      "Video tidak tersedia",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        decoration: TextDecoration.none,
                      ),
                    ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.close, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}
