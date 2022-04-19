import 'dart:io';

import 'package:audiotagger/models/tag.dart';
import 'package:corda_music/classes/filetags.dart';
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audiotagger/audiotagger.dart';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:flutter_exif_plugin/flutter_exif_plugin.dart';
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

    var dir = await getExternalStorageDirectory();
    String path = dir != null ? dir.path : '';

    var fileName = 'George Ezra - Shotgun (Official Lyric Video)';
    var song = '$path/$fileName.mp3';

    Filetags.addTags(song, ['author=Koen']);

    var ffmpeg = new FlutterFFmpeg();
    var arguments = [
      '-i',
      song,
      '-metadata',
      'id=George Ezra',
      '-codec',
      'copy',
      '$path/George Ezra - Shotgun (Official Lyric Video) - temp.mp3'
    ];

    // ffmpeg.executeWithArguments(['-i', song]).then((res) {
    //   print('RES RES $res');
    // });

    // ffmpeg.executeWithArguments(arguments).then((rc) async {
    //   await File(song).delete();
    //   await File('$path/$fileName - temp.mp3').rename(song);

    //   final metadata = await MetadataRetriever.fromFile(File(song));

    //   print('meta $metadata');
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
    print('video $video');

    var dir = await getExternalStorageDirectory();
    String path = dir != null ? dir.path : '';

    var manifest = await yt.videos.streamsClient.getManifest(video.id);
    var streamInfo = manifest.audioOnly.withHighestBitrate();

    print('manifesrt $manifest');

    var title = video.title;
    var author = video.author;
    var thumbnail = video.thumbnails;
    var duration = video.duration;

    print('title $title');
    print('author $author');
    print('thumbnail ${thumbnail.standardResUrl}');
    print('duration $duration');

    // await audioStream.pipe(fileStream);
    // await fileStream.flush();
    // await fileStream.close();

    var stream = yt.videos.streamsClient.get(streamInfo);

    var fileName = video.title;
    var file = File('$path/$fileName.mka');
    var fileStream = file.openWrite();

    await stream.pipe(fileStream);

    await fileStream.flush();
    await fileStream.close();

    // Convert mka to mp3
    var ffmpeg = new FlutterFFmpeg();
    ffmpeg.executeWithArguments(
        ['-i', '$path/$fileName.mka', '$path/$fileName.mp3']).then((res) {
      print('RES RES $res');
    });

    print('streamInfo ${streamInfo}');
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
        ));
  }
}
