import 'package:audio_service/audio_service.dart';
import 'package:corda_music/handlers/my_audio_handler.dart';
import 'package:corda_music/services/counter_service.dart';
import 'package:corda_music/services/page_service.dart';
import 'package:corda_music/widgets/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

Future<void> main() async {
  await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.corda.music.audio',
      androidNotificationChannelName: 'Music playback',
    ),
  );

  getIt.registerSingleton<Counter>(Counter());
  getIt.registerSingleton<PageService>(PageService());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final pageService = getIt.get<PageService>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: pageService.selectedPage$,
      builder: (context, snap) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Scaffold(
            body: pageService.pages.elementAt(pageService.selectedPage),
            bottomNavigationBar: BottomNavigation(),
          ),
        );
      },
    );
  }
}
