import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'player_list_manager.dart';
import 'player_selection_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NFL Players App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PlayerListScreen(prefs: prefs),
    );
  }
}

class PlayerListScreen extends StatefulWidget {
  final SharedPreferences prefs;

  const PlayerListScreen({Key? key, required this.prefs}) : super(key: key);

  @override
  _PlayerListScreenState createState() => _PlayerListScreenState();
}

class _PlayerListScreenState extends State<PlayerListScreen> {
  late final PlayerListManager manager;
  String currentList = 'QB';

  @override
  void initState() {
    super.initState();
    manager = PlayerListManager(widget.prefs);
  }

  @override
  Widget build(BuildContext context) {
    var players = manager.getPlayersByPosition(currentList);

    // Ensure the list has 10 spots
    while (players.length < 10) {
      players.add(PlayerListItem(name: '', position: currentList, team: ''));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('NFL Players List'),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
            value: currentList,
            onChanged: (String? newValue) {
              setState(() {
                currentList = newValue!;
              });
            },
            items: const <String>['QB', 'RB', 'WR', 'TE', 'K', 'DST']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                var player = players[index];
                return ListTile(
                  title: Text(player.name.isEmpty
                      ? 'Empty Slot ${index + 1}'
                      : player.name),
                  subtitle: Text('${player.position} - ${player.team}'),
                  onTap: () => _selectPlayerForSlot(context, player, index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _selectPlayerForSlot(
      BuildContext context, PlayerListItem player, int slotIndex) {
    // Navigate to Player Selection Screen
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PlayerSelectionScreen(
              position: currentList,
              onSelect: (selectedPlayer) {
                setState(() {
                  manager.replacePlayerInList(
                      currentList, slotIndex, selectedPlayer);
                });
              })),
    );
  }
}
