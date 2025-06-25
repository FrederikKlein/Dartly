import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/player.dart';

class PlayersNotifier extends StateNotifier<List<Player>> {
  PlayersNotifier() : super([
    Player(id: '1', name: 'Fredhelm', isEnabled: true),
    Player(id: '2', name: 'Gina', isEnabled: true),
    Player(id: '3', name: 'Charlie', isEnabled: false),
    Player(id: '4', name: 'Diana', isEnabled: true),
  ]);

  void addPlayer(String name) {
    final newPlayer = Player(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
    );
    state = [...state, newPlayer];
  }

  void updatePlayerName(String id, String newName) {
    state = state.map((player) {
      if (player.id == id) {
        return player.copyWith(name: newName);
      }
      return player;
    }).toList();
  }

  void togglePlayerEnabled(String id) {
    state = state.map((player) {
      if (player.id == id) {
        return player.copyWith(isEnabled: !player.isEnabled);
      }
      return player;
    }).toList();
  }

  void reorderPlayers(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final List<Player> newList = List.from(state);
    final Player item = newList.removeAt(oldIndex);
    newList.insert(newIndex, item);
    state = newList;
  }

  void removePlayer(String id) {
    state = state.where((player) => player.id != id).toList();
  }
}

// Provider
final playersProvider = StateNotifierProvider<PlayersNotifier, List<Player>>((ref) {
  return PlayersNotifier();
});