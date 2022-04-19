import 'package:corda_music/pages/home_page.dart';
import 'package:corda_music/pages/music_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _selectedPage = 1;

  var pages = [
    const MyHomePage(title: 'Zoeken'),
    const MusicPage(title: 'Muziek')
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Corda Music',
      theme: ThemeData.dark(),
      home: Scaffold(
        body: pages.elementAt(_selectedPage),
        bottomNavigationBar: BottomNavigationBar(
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
          currentIndex: _selectedPage,
          onTap: (index) {
            setState(() {
              _selectedPage = index;
            });
          },
        ),
      ),
    );
  }
}
