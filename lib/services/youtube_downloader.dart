import 'dart:io';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeDownloader {
  static void downloadMusic(video) async {
    final yt = YoutubeExplode();
    final ffmpeg = FlutterFFmpeg();

    // Get path to external directory.
    var dir = await getExternalStorageDirectory();
    var musicDir = Directory(dir != null ? '${dir.path}/music' : '');

    if (!(await musicDir.exists())) {
      musicDir.create();
    }

    var path = musicDir.path;

    // Get stream.
    var manifest = await yt.videos.streamsClient.getManifest(video.id);
    var streamInfo = manifest.audioOnly.withHighestBitrate();
    var stream = yt.videos.streamsClient.get(streamInfo);

    // Download stream to file.
    var fileName = video.title;
    var file = File('$path/$fileName.mka');
    var fileStream = file.openWrite();

    await stream.pipe(fileStream);
    await fileStream.flush();
    await fileStream.close();

    // Convert mka to mp3.
    var arguments = ['-i', '$path/$fileName.mka', '$path/$fileName.mp3'];
    ffmpeg.executeWithArguments(arguments).then((res) async {
      // Delete mka file.
      await File('$path/$fileName.mka').delete();
      print('File downloaded');
    });
  }
}
