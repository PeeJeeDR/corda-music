import 'package:corda_music/pages/library_page.dart';
import 'package:corda_music/pages/search_page.dart';
import 'package:rxdart/subjects.dart';

class State {
  final int _selectedPage;
  final List _pages;

  State(this._selectedPage, this._pages);
}

class PageService {
  final BehaviorSubject _selectedPage = BehaviorSubject.seeded(0);
  final _pages = BehaviorSubject.seeded([
    const SearchPage(),
    const LibraryPage(),
  ]);

  get selectedPage$ => _selectedPage.stream;
  int get selectedPage => _selectedPage.value;

  List get pages => _pages.value;

  changePage(int page) {
    _selectedPage.add(page);
  }
}
