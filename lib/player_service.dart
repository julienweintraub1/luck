import 'dart:convert';
import 'package:flutter/services.dart';
import 'player.dart';

class PlayerService {
  Future<List<Player>> fetchPlayers() async {
    final jsonString = await rootBundle.loadString('assets/player.json');
    final List<dynamic> playerJsonList = json.decode(jsonString) as List;
    return playerJsonList.map((json) => Player.fromJson(json)).toList();
  }
}
