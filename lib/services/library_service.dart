import 'dart:io';
import 'package:corda_music/handlers/my_audio_handler.dart';
import 'package:corda_music/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/subjects.dart';

class LibraryService {
  final BehaviorSubject _library = BehaviorSubject.seeded([]);

  get library => _library;

  getLibrary(loadQueue) async {
    final audioHandler = getIt.get<MyAudioHandler>();

    var dir = await getExternalStorageDirectory();
    var musicDir = Directory(dir != null ? '${dir.path}/music' : '');

    if (await musicDir.exists()) {
      var path = musicDir.path;
      _library.add(Directory(path.toString()).listSync());

      if (loadQueue) {
        audioHandler.loadQueue(library.value);
      }
    }
  }
}
