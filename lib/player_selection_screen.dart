import 'package:flutter/material.dart';
import 'player.dart';
import 'player_service.dart';
import 'player_list_manager.dart'; // Import PlayerListItem

class PlayerSelectionScreen extends StatelessWidget {
  final String position;
  final Function(PlayerListItem) onSelect;

  const PlayerSelectionScreen(
      {Key? key, required this.position, required this.onSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final playerService = PlayerService();

    return Scaffold(
      appBar: AppBar(title: const Text('Select Player')),
      body: FutureBuilder<List<Player>>(
        future: playerService.fetchPlayersByPosition(position),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var player = snapshot.data![index];
                return ListTile(
                  title: Text(player.name),
                  onTap: () {
                    onSelect(PlayerListItem(
                      name: player.name,
                      position: player.position,
                      team: player.team,
                    ));
                    Navigator.pop(context);
                  },
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
