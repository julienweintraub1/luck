import 'dart:convert';
import 'package:http/http.dart' as http;
import 'player.dart';

class PlayerService {
  Future<List<Player>> fetchPlayers() async {
    final url = 'YOUR_JSON_URL'; // Replace with your JSON URL
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      List<dynamic> playerJson = json.decode(response.body);
      return playerJson.map((json) => Player.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load players');
    }
  }
}
