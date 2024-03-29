import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

class StateModel {
  StateModel({required this.songs});

  List songs = [];

  StateModel copyWith({List? songs}) {
    return StateModel(songs: songs ?? this.songs);
  }
}

class LibraryNotifier extends StateNotifier<StateModel> {
  LibraryNotifier() : super(StateModel(songs: []));

  void getSongs() async {
    var dir = await getExternalStorageDirectory();
    var musicDir = Directory(dir != null ? '${dir.path}/music' : '');

    if (await musicDir.exists()) {
      var path = musicDir.path;
      var songs = Directory(path.toString()).listSync();

      state = state.copyWith(
        songs: songs,
      );
    }
  }
}

final libraryProvider = StateNotifierProvider<LibraryNotifier, StateModel>((_) {
  return LibraryNotifier();
});
