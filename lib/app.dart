import 'package:corda_music/pages/search_page.dart';
import 'package:corda_music/pages/music_page.dart';
import 'package:corda_music/providers/pages_provider.dart';
import 'package:corda_music/widgets/app_bottom_sheet.dart';
import 'package:corda_music/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  var pages = [
    const SearchPage(title: 'Zoeken'),
    const MusicPage(title: 'Muziek')
  ];

  @override
  Widget build(BuildContext context) {
    final selectedPage = ref.watch(pagesProvider);

    return MaterialApp(
      title: 'Corda Music',
      theme: ThemeData.dark(),
      home: Scaffold(
        body: pages.elementAt(selectedPage),
        bottomSheet: const AppBottomSheet(),
        bottomNavigationBar: const AppBottomNavigationBar(),
      ),
    );
  }
}
