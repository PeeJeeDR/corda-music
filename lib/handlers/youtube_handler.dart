import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeHandler {
  final yt = YoutubeExplode();

  Future<VideoSearchList> getMusic(query) async {
    return await yt.search(query);
  }

  Future<void> downloadMusic(video) async {
    final dir = await getExternalStorageDirectory();
    final musicDir = Directory(dir != null ? '${dir.path}/music' : '');

    if (!(await musicDir.exists())) {
      musicDir.create();
    }

    // Path to music directory.
    final path = musicDir.path;

    // Get stream.
    final manifest = await yt.videos.streamsClient.getManifest(video.id);
    final streamInfo = manifest.audioOnly.withHighestBitrate();
    final stream = yt.videos.streamsClient.get(streamInfo);

    // Prepare file for stream.
    final fileName = video.title;
    final file = File('$path/$fileName.mp3');
    final fileStream = file.openWrite();

    // Download stream to file.
    await stream.pipe(fileStream);
    await fileStream.flush();
    await fileStream.close();
  }
}
