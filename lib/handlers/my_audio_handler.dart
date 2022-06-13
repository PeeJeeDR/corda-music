import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class MyAudioHandler extends BaseAudioHandler {
  final _player = AudioPlayer();
  final _playlist = ConcatenatingAudioSource(children: []);
  final _queue = ConcatenatingAudioSource(children: []);

  MyAudioHandler() {
    loadEmptyQueue();
    notifyAudioHandlerAboutPlaybackEvents();
  }

  Future<void> loadEmptyQueue() async {
    try {
      await _player.setAudioSource(_queue);
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> loadQueue(List library) async {
    final mediaItems = library
        .map((song) => MediaItem(
              id: song.path,
              album: 'Album name',
              title: 'test',
              displayTitle: 'Jooow',
              rating: Rating.newStarRating(RatingStyle.range5stars, 4),
              artist: 'Sigrid',
              duration: const Duration(microseconds: 345432),
              extras: {
                'filePath': song.path,
              },
            ))
        .toList();

    addQueueItems(mediaItems);
  }

  // THIS FUNCTION NEEDS REWORK.
  onNewFileDownload(file) async {
    print('ON NEW FILE DOWNLOAD!!! $file');

    var item = MediaItem(id: file.path ?? '', title: 'Hoi', extras: {
      'filePath': file.path,
    });

    print('ITEEEEEM $item');

    addQueueItem(item);
  }

  onSongClick(index) async {
    _player.seek(null, index: index);

    playbackState.add(PlaybackState(controls: [
      MediaControl.skipToPrevious,
      MediaControl.pause,
      MediaControl.stop,
      MediaControl.skipToNext,
    ]));

    play();
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    // manage Just Audio
    final audioSource = mediaItems.map((mediaItem) {
      return AudioSource.uri(Uri.file(mediaItem.extras!['filePath']));
    });
    _playlist.addAll(audioSource.toList());
    _player.setAudioSource(_playlist);

    print('Media itemsssss $mediaItems');

    // notify system
    // final newQueue = queue.value..addAll(mediaItems);
    // queue.add(newQueue);

    queue.add(mediaItems);

    print('queue $queue');
  }

  void notifyAudioHandlerAboutPlaybackEvents() {
    print('NOTIFY!!');
    _player.playbackEventStream.listen((PlaybackEvent event) {
      print('STATE CHANGED! $event');

      final playing = _player.playing;
      playbackState.add(playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.stop,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
        },
        androidCompactActionIndices: const [0, 1, 3],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[_player.processingState]!,
        playing: playing,
        updatePosition: _player.position,
        bufferedPosition: _player.bufferedPosition,
        speed: _player.speed,
        queueIndex: event.currentIndex,
      ));
      print('Playback state ${playbackState.value}');
    });
  }

  @override
  Future<void> play() async {
    // playbackState.add(playbackState.value.copyWith(
    //   playing: true,
    //   controls: [MediaControl.pause],
    // ));

    await _player.play();
  }

  @override
  Future<void> pause() async {
    // playbackState.add(playbackState.value.copyWith(
    //   playing: false,
    //   controls: [MediaControl.play],
    // ));

    await _player.pause();
  }

  @override
  Future<void> stop() async {
    print('Stop audio');
  }
}
