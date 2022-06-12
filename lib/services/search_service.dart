import 'package:corda_music/handlers/youtube_handler.dart';
import 'package:rxdart/subjects.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class SearchService {
  final youtubeHandler = YoutubeHandler();
  final BehaviorSubject<List> _searchResults = BehaviorSubject.seeded([]);

  get searchResults$ => _searchResults.stream;
  List get searchResults => _searchResults.value;

  Future<void> searchMusic(String query) async {
    VideoSearchList results = await youtubeHandler.getMusic(query);
    print('results $results');
    _searchResults.add(results);
  }
}
