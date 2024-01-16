import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'player_list_manager.dart';

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

  @override
  void initState() {
    super.initState();
    manager = PlayerListManager(widget.prefs);
  }

  String currentList = 'QB';

  @override
  Widget build(BuildContext context) {
    var players = manager.getPlayersByPosition(currentList);
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
                return ListTile(
                  title: Text(players[index].name),
                  subtitle: Text(
                      '${players[index].position} - ${players[index].team}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
