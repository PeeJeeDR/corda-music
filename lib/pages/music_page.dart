import 'dart:io';
import 'package:corda_music/services/audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';

const String noSongs = 'You have no songs yet.';
const String errorSongs = 'Something went wrong while fetching your songs.';

class MusicPage extends StatefulWidget {
  const MusicPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  final AudioService audioService = GetIt.instance.get<AudioService>();
  final player = AudioPlayer();
  var _playing = false;

  onMusicTap(song) {
    player.setFilePath(song.path);
    player.play();

    player.playerStateStream.listen((state) {
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

    audioService.getMusic();
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
            child: StreamBuilder(
              stream: audioService.songsStream$,
              builder: (context, AsyncSnapshot<Object?> snap) {
                if (snap.connectionState == ConnectionState.active) {
                  List data = snap.data as List<FileSystemEntity>;

                  if (data.isNotEmpty) {
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(data[index]
                              .path
                              .toString()
                              .split('/')
                              .last
                              .split('.mp3')
                              .first),
                          onTap: () => onMusicTap(data[index]),
                        );
                      },
                    );
                  }

                  if (data.isEmpty) {
                    return const Text(noSongs);
                  }
                }

                if (snap.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                return const Text(errorSongs);
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
