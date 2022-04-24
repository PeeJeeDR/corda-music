import 'package:corda_music/app.dart';
import 'package:corda_music/services/audio_player.dart';
import 'package:corda_music/services/counter.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() {
  GetIt.instance.registerSingleton<CounterService>(CounterService());
  GetIt.instance.registerSingleton<AudioService>(AudioService());
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyApp();
  }
}
