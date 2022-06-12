import 'package:corda_music/main.dart';
import 'package:corda_music/services/page_service.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({Key? key}) : super(key: key);

  final pageService = getIt.get<PageService>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: pageService.selectedPage$,
      builder: (context, snap) {
        return BottomNavigationBar(
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                pageService.selectedPage == 1
                    ? Icons.library_music
                    : Icons.library_music_outlined,
              ),
              label: 'Library',
            ),
          ],
          currentIndex: pageService.selectedPage,
          onTap: (index) {
            pageService.changePage(index);
          },
        );
      },
    );
  }
}
