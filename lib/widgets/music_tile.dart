import 'package:corda_music/handlers/youtube_handler.dart';
import 'package:corda_music/main.dart';
import 'package:flutter/material.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class MusicTile extends StatelessWidget {
  MusicTile({Key? key, required this.song}) : super(key: key);

  final Video song;
  final youtubeHandler = getIt.get<YoutubeHandler>();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(
        top: 5,
        bottom: 5,
      ),
      leading: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(song.thumbnails.lowResUrl),
          ),
          const SizedBox.shrink(),
        ],
      ),
      title: Text(song.title),
      onTap: () => youtubeHandler.downloadMusic(song),
    );
  }
}
