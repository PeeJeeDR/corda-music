import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateModel {
  StateModel();

  StateModel copyWith() {
    return StateModel();
  }
}

class PlayerNotifier extends StateNotifier<StateModel> {
  PlayerNotifier() : super(StateModel());
  // Place methods here.
}

final PlayerProvider = StateNotifierProvider<PlayerNotifier, StateModel>((_) {
  return PlayerNotifier();
});
