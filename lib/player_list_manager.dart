import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PlayerListManager {
  final SharedPreferences prefs;

  PlayerListManager(this.prefs);

  Map<String, List<PlayerListItem>> playerLists = {
    'QB': [],
    'RB': [],
    'WR': [],
    'TE': [],
    'K': [],
    'DST': [],
  };

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
        List<PlayerListItem> tempList = (value as List)
            .map((item) => PlayerListItem.fromJson(item))
            .toList();
        playerLists[key] = tempList;
      });
    }
  }

  void addPlayer(String listName, PlayerListItem player) {
    if (playerLists.containsKey(listName)) {
      playerLists[listName]!.add(player);
    }
  }

  void removePlayer(String listName, PlayerListItem player) {
    if (playerLists.containsKey(listName)) {
      playerLists[listName]!.removeWhere((p) => p.name == player.name);
    }
  }

  List<PlayerListItem> getPlayersByPosition(String position) {
    return playerLists[position] ?? [];
  }

  void replacePlayerInList(
      String listName, int index, PlayerListItem newPlayer) {
    if (playerLists.containsKey(listName) &&
        index < playerLists[listName]!.length) {
      playerLists[listName]![index] = newPlayer;
    }
  }
}

class PlayerListItem {
  final String name;
  final String position;
  final String team;

  PlayerListItem(
      {required this.name, required this.position, required this.team});

  factory PlayerListItem.fromJson(Map<String, dynamic> json) {
    return PlayerListItem(
      name: json['name'] as String,
      position: json['position'] as String,
      team: json['team'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'position': position,
      'team': team,
    };
  }
}
