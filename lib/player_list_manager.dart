import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'player.dart';

class PlayerListManager {
  final SharedPreferences prefs;
  Map<String, List<Player>> playerLists = {
    'QB': [],
    'RB': [],
    'WR': [],
    'TE': [],
    'K': [],
    'DST': [],
  };

  PlayerListManager(this.prefs); // Constructor with SharedPreferences parameter

  Future<void> savePlayerLists() async {
    Map<String, dynamic> playerListsMap = {};
    playerLists.forEach((key, value) {
      playerListsMap[key] = value.map((player) => player.toJson()).toList();
    });
    await prefs.setString('playerLists', jsonEncode(playerListsMap));
  }

  Future<void> loadPlayerLists() async {
    String? playerListsString = prefs.getString('playerLists');
    if (playerListsString != null) {
      Map<String, dynamic> playerListsMap = jsonDecode(playerListsString);
      playerListsMap.forEach((key, value) {
        List<Player> tempList =
            (value as List).map((item) => Player.fromJson(item)).toList();
        playerLists[key] = tempList;
      });
    }
  }

  void addPlayer(String listName, Player player) {
    if (playerLists.containsKey(listName)) {
      playerLists[listName]!.add(player);
    }
  }

  void removePlayer(String listName, Player player) {
    if (playerLists.containsKey(listName)) {
      playerLists[listName]!.removeWhere((p) => p.name == player.name);
    }
  }

  List<Player> getPlayersByPosition(String position) {
    return playerLists[position] ?? [];
  }
}
