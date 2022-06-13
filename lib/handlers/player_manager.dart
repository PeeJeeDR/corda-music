import 'package:audio_service/audio_service.dart';
import 'package:corda_music/main.dart';
import 'package:corda_music/services/library_service.dart';
import 'package:just_audio/just_audio.dart';

class PlayerManager {
  void init() async {
    await _loadLibrary();
  }

  Future<void> _loadLibrary() async {
    final libraryService = getIt.get<LibraryService>();
    final audioHandler = getIt.get<AudioHandler>();

    await libraryService.getLibrary();

    final library = libraryService.library.value;
    final mediaItems = library.map((song) => MediaItem(
          id: song.path,
          album: 'Album er bij',
          title: 'Dit is de titel',
          displayTitle: 'Hello',
          extras: {
            'filePath': song.path,
          },
        ));

    audioHandler.addQueueItems(List<MediaItem>.from(mediaItems.toList()));
  }

  void onSongClick(index) {
    final player = getIt.get<AudioPlayer>();
    final audioHandler = getIt.get<AudioHandler>();

    print('Song click $index');
    player.seek(Duration.zero, index: index);
    audioHandler.play();
  }
}
