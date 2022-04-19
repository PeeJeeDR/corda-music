import 'dart:io';

import 'package:audiotagger/models/tag.dart';
import 'package:corda_music/classes/filetags.dart';
import 'package:corda_music/services/youtube_downloader.dart';
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audiotagger/audiotagger.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var yt = YoutubeExplode();
  final tagger = Audiotagger();

  Future _getVideos() async {
    VideoSearchList searchResults = await yt.search('George ezra');

    // print('searchResults $searchResults');

    // var dir = await getExternalStorageDirectory();
    // String path = dir != null ? dir.path : '';

    // var fileName = 'George Ezra - Listen to the man';
    // var song = '$path/$fileName.mp3';

    // // Filetags.addTags(song, ['author=Koen']);

    // var ffmpeg = new FlutterFFmpeg();
    // var arguments = [
    //   '-i',
    //   song,
    //   '-metadata',
    //   'genre=sito',
    //   '-codec',
    //   'copy',
    //   '$path/George Ezra - Shotgun (Official Lyric Video) - temp.mp3'
    // ];

    // print('song $song');

    // var artwork = await tagger.readArtwork(path: song);
    // var results = await tagger.writeTags(
    //     path: song,
    //     tag: Tag(
    //         title: 'Zingen maar',
    //         artist: 'George Ezra',
    //         genre: 'metal',
    //         year: '2022'));

    // var tags = await tagger.readTags(path: song);

    // print('ARTWORK $artwork');
    // print('RESULTS $results');
    // print('TAGS ${tags?.toMap()}');

    // ffmpeg.executeWithArguments(['-i', song]).then((res) {
    //   print('RES RES $res');
    // });

    // ffmpeg.executeWithArguments(arguments).then((rc) async {
    //   await File(song).delete();
    //   await File('$path/$fileName - temp.mp3').rename(song);
    // });

    // final metadata = await MetadataRetriever.fromFile(File(song));
    // print('meta $metadata');

    // });

    // var metadata = await MetadataRetriever.fromFile(File(song));

    // print('metadata $metadata');

    // var Dir = Directory(path);
    // await for (var entity in Dir.list(recursive: true, followLinks: false)) {
    //   print(entity.path);
    // }

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
      body: FutureBuilder(
        future: _getVideos(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return const Text('Something went wrong wile fetching data');
          }

          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(snapshot.data[index].title),
                onTap: () => onVideoPress(snapshot.data[index]),
              );
            },
          );
        },
      ),
    );
  }
}
