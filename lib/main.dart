import 'package:flutter/material.dart';
import 'player.dart';
import 'player_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NFL Players App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const PlayerListScreen(),
    );
  }
}

class PlayerListScreen extends StatelessWidget {
  const PlayerListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PlayerService playerService = PlayerService();

    return Scaffold(
      appBar: AppBar(title: const Text('NFL Players')),
      body: FutureBuilder<List<Player>>(
        future: playerService.fetchPlayers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Player player = snapshot.data![index];
                return ListTile(
                  title: Text(player.name),
                  subtitle: Text('${player.position} - ${player.team}'),
                );
              },
            );
          } else {
            return const Center(child: Text('No players found'));
          }
        },
      ),
    );
  }
}
