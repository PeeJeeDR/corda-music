import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerHandler extends BaseAudioHandler {
  final _player = AudioPlayer();

  AudioPlayerHandler() {
    _player.setUrl("https://exampledomain.com/song.mp3");
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();
}
