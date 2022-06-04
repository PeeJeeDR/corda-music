import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class MyAudioHandler extends BaseAudioHandler {
  final _player = AudioPlayer();

  MyAudioHandler() {
    const u =
        'https://thinknews.com.ng/wp-content/uploads/2022/03/Imagine_Dragons_Bones_(thinkNews.com.ng).mp3';

    _player.setUrl(u);

    mediaItem.add(
      MediaItem(
        id: u,
        title: 'Bones',
        artist: 'Imagine Dragons',
        artUri: Uri.parse(
            'https://linkstorage.linkfire.com/medialinks/images/aa55a00e-e887-4dc8-a3aa-053f802cb3b4/artwork-440x440.jpg'),
      ),
    );

    playbackState.add(PlaybackState(
      controls: [
        MediaControl.skipToPrevious,
        MediaControl.pause,
        MediaControl.stop,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      playing: false,
    ));
  }

  void loadMusicItems() {
    print('Load music items');
  }

  @override
  Future<void> play() async {
    await _player.play();

    playbackState.add(playbackState.value.copyWith(
      playing: true,
    ));
  }

  @override
  Future<void> pause() async {
    _player.pause();

    playbackState.add(playbackState.value.copyWith(
      playing: false,
    ));
  }

  @override
  Future<void> stop() async {
    print('Stop audio');
  }
}
