class PlayerListItem {
  final String name;
  final String position;
  final String team;

  PlayerListItem({
    required this.name,
    required this.position,
    required this.team,
  });

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
