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
              id: 'test',
              title: 'test',
              extras: {
                'filePath': song.path,
              },
            ))
        .toList();

    addQueueItems(mediaItems);
  }

  onSongClick(index) async {
    _player.seek(null, index: index);
    play();
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    print('ADD QUEUE ITEMS!');
    // manage Just Audio
    final audioSource = mediaItems.map((mediaItem) {
      return AudioSource.uri(Uri.file(mediaItem.extras!['filePath']));
    });
    _playlist.addAll(audioSource.toList());
    _player.setAudioSource(_playlist);

    // notify system
    final newQueue = queue.value..addAll(mediaItems);
    queue.add(newQueue);

    print('queue $queue');
  }

  void notifyAudioHandlerAboutPlaybackEvents() {
    _player.playbackEventStream.listen((PlaybackEvent event) {
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
    });
  }

  @override
  Future<void> play() async {
    playbackState.add(playbackState.value.copyWith(
      playing: true,
      controls: [MediaControl.pause],
    ));

    await _player.play();
  }

  @override
  Future<void> pause() async {
    playbackState.add(playbackState.value.copyWith(
      playing: false,
      controls: [MediaControl.play],
    ));

    await _player.pause();
  }

  @override
  Future<void> stop() async {
    print('Stop audio');
  }
}
