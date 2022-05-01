import 'dart:async';
import 'package:corda_music/widgets/music_tile.dart';
import 'package:flutter/material.dart';
import 'package:corda_music/services/youtube_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:easy_debounce/easy_debounce.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
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
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 15,
            left: 10,
            right: 10,
            bottom: 0,
          ),
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              labelText: 'Search for music',
              floatingLabelBehavior: FloatingLabelBehavior.never,
            ),
            onChanged: _onSearchChanged,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
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
                      return MusicTile(song: snapshot.data[index]);
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
