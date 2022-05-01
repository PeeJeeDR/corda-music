import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateModel {
  StateModel({required this.counter});

  int counter;

  StateModel copyWith({int? counter}) {
    return StateModel(counter: counter ?? this.counter);
  }
}

class CounterNotifier extends StateNotifier<StateModel> {
  CounterNotifier() : super(StateModel(counter: 3));

  void increment() {
    state = state.copyWith(counter: state.counter + 1);
  }

  void decrement() {
    state = state.copyWith(counter: state.counter - 1);
  }
}

final counterProvider = StateNotifierProvider<CounterNotifier, StateModel>((_) {
  return CounterNotifier();
});
