import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/subjects.dart';

class AudioService {
  final BehaviorSubject _songs = BehaviorSubject.seeded([]);

  Stream get songsStream$ => _songs.stream;
  List get currentSongs => _songs.value;

  getMusic() async {
    var dir = await getExternalStorageDirectory();
    var musicDir = Directory(dir != null ? '${dir.path}/music' : '');

    if (await musicDir.exists()) {
      var path = musicDir.path;

      _songs.add(Directory(path.toString()).listSync());
    }
  }
}
