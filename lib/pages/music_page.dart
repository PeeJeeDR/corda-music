import 'dart:io';

import 'package:corda_music/services/audio_handler.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  var _music = [];
  final player = AudioPlayer();
  var _playing = false;

  setMusic() async {
    var dir = await getExternalStorageDirectory();
    var musicDir = Directory(dir != null ? '${dir.path}/music' : '');

    if (await musicDir.exists()) {
      var path = musicDir.path;

      setState(() {
        _music = Directory(path.toString()).listSync();
      });
    }
  }

  onMusicTap(song) {
    print('song $song');

    player.setFilePath(song.path);
    player.play();

    player.playerStateStream.listen((state) {
      print('state ${state.playing}');
      setState(() {
        _playing = state.playing;
      });
    });
  }

  onAudioControlButton() {
    if (_playing) {
      player.pause();
    } else {
      player.play();
    }
  }

  @override
  void initState() {
    super.initState();
    setMusic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _music.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_music[index]
                      .path
                      .toString()
                      .split('/')
                      .last
                      .split('.mp3')
                      .first),
                  onTap: () => onMusicTap(_music[index]),
                );
              },
            ),
          ),
          ButtonBar(
            children: [
              IconButton(
                onPressed: onAudioControlButton,
                icon: Icon(_playing ? Icons.pause : Icons.play_arrow),
              )
            ],
          )
        ],
      ),
    );
  }
}
