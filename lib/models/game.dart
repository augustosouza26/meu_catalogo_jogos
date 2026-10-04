class Game {
  final String id;
  final String name;
  final String genre;
  final String platform;
  final double rating;
  final String description;

  const Game({
    required this.id,
    required this.name,
    required this.genre,
    required this.platform,
    required this.rating,
    required this.description,
  });

  Game copyWith({
    String? name,
    String? genre,
    String? platform,
    double? rating,
    String? description,
  }) {
    return Game(
      id: id, // a identidade nunca muda
      name: name ?? this.name,
      genre: genre ?? this.genre,
      platform: platform ?? this.platform,
      rating: rating ?? this.rating,
      description: description ?? this.description,
    );
  }
}
