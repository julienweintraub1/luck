import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nfl_players_app/player_list_manager.dart';
import 'package:nfl_players_app/player.dart';

void main() {
  TestWidgetsFlutterBinding
      .ensureInitialized(); // Initialize the test environment

  group('PlayerListManager', () {
    setUp(() {
      // Set up the mock initial values for SharedPreferences
      SharedPreferences.setMockInitialValues({});
    });

    test('should save and load player lists', () async {
      // Create an instance of SharedPreferences with the mock initial values
      final prefs = await SharedPreferences.getInstance();

      // Instantiate the PlayerListManager with the mock SharedPreferences
      final manager = PlayerListManager(prefs);

      // Add a player to the QB list
      manager.addPlayer(
          'QB', Player(name: 'Test Player', position: 'QB', team: 'Test Team'));

      // Save player lists
      await manager.savePlayerLists();

      // Reload the manager with a new SharedPreferences instance and load the lists
      final newManager =
          PlayerListManager(await SharedPreferences.getInstance());
      await newManager.loadPlayerLists();

      // Expect the added player's name to be 'Test Player'
      expect(newManager.playerLists['QB']?.first.name, 'Test Player');
    });
  });
}
