import 'package:corda_music/providers/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppBottomSheet extends ConsumerWidget {
  const AppBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);

    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Counter: $counter'),
          FloatingActionButton.small(
            child: const Icon(Icons.pause),
            onPressed: () {
              ref.read(counterProvider.notifier).increment();
            },
          ),
        ],
      ),
    );
  }
}
