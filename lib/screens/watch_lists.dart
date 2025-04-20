import 'package:flutter/material.dart';
import 'package:movie_app/constant/style.dart';
import 'package:movie_app/movie_widgets/movie_watch_lists.dart';
import 'package:movie_app/tv_widgets/tv_watch_lists.dart';

class WatchLists extends StatefulWidget {
  const WatchLists({super.key});

  @override
  State<WatchLists> createState() => _WatchListsState();
}

class _WatchListsState extends State<WatchLists> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watch Lists'),
          bottom: const TabBar(
            indicatorWeight: 5,
            indicatorColor: Style.secondaryColor,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: [
              Text(
                'Movies',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                'TVs',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            MovieWatchLists(),
            TvWatchLists(),
          ],
        ),
      ),
    );
  }
}
