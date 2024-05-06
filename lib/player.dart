class Player {
  String name;
  int score;

  Player({
    required this.name,
    required this.score,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      name: json['name'],
      score: json['score'],
    );
  }
}
