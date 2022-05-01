import 'package:corda_music/providers/pages_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBottomNavigationBar extends ConsumerWidget {
  const AppBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedPage = ref.watch(pagesProvider);

    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.music_note),
          label: 'Music',
        ),
      ],
      currentIndex: selectedPage,
      onTap: (index) {
        ref.read(pagesProvider.notifier).state = index;
      },
    );
  }
}
