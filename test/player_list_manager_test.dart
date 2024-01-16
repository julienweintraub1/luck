import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nfl_players_app/player_list_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues(
      {}); // Necessary for tests involving SharedPreferences

  group('PlayerListManager', () {
    test('should save and load player lists', () async {
      final prefs = await SharedPreferences.getInstance();
      final manager = PlayerListManager(prefs);

      // Test adding a player list item
      var testPlayerListItem = PlayerListItem(
          name: 'Test Player', position: 'QB', team: 'Test Team');
      manager.addPlayer('QB', testPlayerListItem);
      await manager.savePlayerLists();

      // Test loading the player lists
      final newManager = PlayerListManager(prefs);
      await newManager.loadPlayerLists();

      expect(newManager.playerLists['QB']?.first.name, 'Test Player');
    });
  });
}
