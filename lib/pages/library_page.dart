import 'package:corda_music/handlers/my_audio_handler.dart';
import 'package:corda_music/main.dart';
import 'package:corda_music/services/library_service.dart';
import 'package:flutter/material.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final libraryService = getIt.get<LibraryService>();
    final audioHandler = getIt.get<MyAudioHandler>();

    libraryService.getLibrary(false);

    return StreamBuilder(
      stream: libraryService.library.stream,
      builder: (context, snap) {
        final library = libraryService.library.value;

        return ListView.builder(
          itemCount: library.length,
          itemBuilder: (ctx, index) {
            return TextButton(
              child: Text(library[index].path),
              onPressed: () => {
                audioHandler.onSongClick(index),
              },
            );
          },
        );
      },
    );
  }
}
