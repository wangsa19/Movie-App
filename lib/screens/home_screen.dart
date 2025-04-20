import 'package:flutter/material.dart';
import 'package:movie_app/constant/style.dart';
import 'package:movie_app/screens/movie_screen.dart';
import 'package:movie_app/screens/tv_screen.dart';
import 'package:movie_app/screens/watch_lists.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController();
    void onTapIcon(int index) {
      _controller.animateToPage(
        index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    }

    return Scaffold(
      appBar: _currentIndex != 2 ? AppBar(title: _buildTitle(_currentIndex)) : null,
      body: PageView(
        controller: _controller,
        children: const <Widget>[
          MovieScreen(),
          TvScreen(),
          WatchLists(),
        ],
        onPageChanged: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Style.primaryColor,
        selectedItemColor: Style.secondaryColor,
        unselectedItemColor: Style.textColor,
        currentIndex: _currentIndex,
        onTap: onTapIcon,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'Movies'),
          BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'TVs'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Watch Lists'),
        ],
      ),
    );
  }

  _buildTitle(int index) {
    switch (index) {
      case 0:
        return const Text('Movie Shows');
      case 1:
        return const Text('TV Shows');
      default:
        return null;
    }
  }
}
