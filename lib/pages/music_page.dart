import 'package:corda_music/providers/songs_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const String noSongs = 'You have no songs yet.';
const String errorSongs = 'Something went wrong while fetching your songs.';

class MusicPage extends ConsumerStatefulWidget {
  const MusicPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  ConsumerState<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends ConsumerState<MusicPage> {
  @override
  Widget build(BuildContext context) {
    final songs = ref.watch(songsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          songs.when(
            data: (songs) {
              return Expanded(
                child: ListView.builder(
                  itemCount: songs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        songs[index]
                            .path
                            .toString()
                            .split('/')
                            .last
                            .split('.mp3')
                            .first,
                      ),
                      onTap: () => print('Helloo'),
                    );
                  },
                ),
              );
            },
            error: (err, stack) => Text('error: $err'),
            loading: () => const CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
