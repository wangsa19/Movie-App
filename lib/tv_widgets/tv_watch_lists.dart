import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movie_app/constant/style.dart';
import 'package:movie_app/model/hive_tv_model.dart';

class TvWatchLists extends StatefulWidget {
  const TvWatchLists({super.key});

  @override
  State<TvWatchLists> createState() => _TvWatchListsState();
}

class _TvWatchListsState extends State<TvWatchLists> {
  late Box<HiveTVModel> _tvWatchLists;
  @override
  void initState() {
    _tvWatchLists = Hive.box<HiveTVModel>('tv_lists');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child:
          _tvWatchLists.isEmpty
              ? const Center(
                child: Text(
                  "No Movies in Watch List",
                  style: TextStyle(
                    color: Style.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              )
              : SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ValueListenableBuilder(
                      valueListenable: _tvWatchLists.listenable(),
                      builder: (context, Box<HiveTVModel> item, _) {
                        List<int> keys = item.keys.cast<int>().toList();
                        return ListView.builder(
                          itemCount: keys.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final key = keys[index];
                            final HiveTVModel? _item = item.get(key);
                            return Card(
                              elevation: 5,
                              child: ListTile(
                                title: Text(_item!.name),
                                subtitle: Text(
                                  _item.overview,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                leading: Image.network(
                                  "https://image.tmdb.org/t/p/w200/${_item.poster}",
                                  fit: BoxFit.cover,
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _tvWatchLists.deleteAt(index);
                                    });
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
    );
  }
}
