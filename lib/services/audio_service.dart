import 'dart:io';
import 'package:audiotagger/audiotagger.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/subjects.dart';

class AudioService {
  final player = AudioPlayer();

  final _songs = [];
  int _counter = 0;

  // final BehaviorSubject _songs = BehaviorSubject.seeded([]);
  final BehaviorSubject _currentPlaying = BehaviorSubject.seeded('');
  final BehaviorSubject _isPlaying = BehaviorSubject.seeded(false);

  // Stream get songsStream$ => _songs.stream;
  Stream get currentPlayingStream$ => _currentPlaying.stream;
  Stream get isPlayingStream$ => _isPlaying.stream;

  List get songs {
    return _songs;
  }

  int get counter {
    return _counter;
  }

  void incrementCounter() {
    _counter = _counter + 1;
  }

  getMusic() async {
    var dir = await getExternalStorageDirectory();
    var musicDir = Directory(dir != null ? '${dir.path}/music' : '');

    if (await musicDir.exists()) {
      var path = musicDir.path;

      _songs.add(Directory(path.toString()).listSync());
    }
  }

  setPlayingSong(song) async {
    final tagger = Audiotagger();
    var tags = await tagger.readTags(path: song.path);

    player.setFilePath(song.path);

    if (tags != null) {
      _currentPlaying.add(tags.title);
    }

    player.play();

    player.playerStateStream.listen((state) {
      _isPlaying.add(true);
    });
  }

  togglePlaying() {}
}
