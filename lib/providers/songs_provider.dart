import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

final songsProvider = FutureProvider((ref) async {
  var dir = await getExternalStorageDirectory();
  var musicDir = Directory(dir != null ? '${dir.path}/music' : '');

  if (await musicDir.exists()) {
    var path = musicDir.path;
    return Directory(path.toString()).listSync();
  }

  return [];
});
