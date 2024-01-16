class Player {
  final String name;
  final String position;
  final String team;

  Player({required this.name, required this.position, required this.team});

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
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
