import 'dart:async';
import 'package:corda_music/services/counter.dart';
import 'package:flutter/material.dart';
import 'package:corda_music/services/youtube_downloader.dart';
import 'package:get_it/get_it.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:easy_debounce/easy_debounce.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CounterService counterService = GetIt.instance.get<CounterService>();

  final _yt = YoutubeExplode();
  String searchQuery = 'George Ezra';

  void _onSearchChanged(String query) {
    if (query != searchQuery) {
      EasyDebounce.debounce(
        'search-debounce',
        const Duration(milliseconds: 500),
        () {
          setState(() {
            searchQuery = query;
          });
        },
      );
    }
  }

  Future _getVideos() async {
    VideoSearchList searchResults = await _yt.search(searchQuery);
    return searchResults;
  }

  void onVideoPress(video) async {
    YoutubeDownloader.downloadMusic(video);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            StreamBuilder(
              stream: counterService.stream$,
              builder: (context, snap) {
                return FloatingActionButton(
                  onPressed: () => counterService.inrement(),
                  child: Text('${snap.data}'),
                );
              },
            ),
            FloatingActionButton(onPressed: () => counterService.inrement()),
            StreamBuilder(
              stream: counterService.stream$,
              builder: (context, snap) {
                return Text('${snap.data}');
              },
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText:
                      'Search for music ${counterService.current.toString()}',
                ),
                onChanged: _onSearchChanged,
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: _getVideos(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Text(
                        'Something went wrong wile fetching data');
                  }

                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        contentPadding:
                            const EdgeInsets.only(top: 5, bottom: 5),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                              snapshot.data[index].thumbnails.lowResUrl),
                        ),
                        title: Text(snapshot.data[index].title),
                        onTap: () => onVideoPress(snapshot.data[index]),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
