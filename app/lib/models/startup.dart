class Startup {
  int id;
  String startupName;
  String tagline;
  String description;
  int voteCount;
  double rating;

  Startup({
    required this.id,
    required this.startupName,
    required this.tagline,
    required this.description,
    required this.voteCount,
    required this.rating,
  });

  factory Startup.fromJson(Map<String, dynamic> json) => Startup(
    id: json["id"],
    startupName: json["startup_name"],
    tagline: json["tagline"],
    description: json["description"],
    voteCount: json["vote_count"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "startup_name": startupName,
    "tagline": tagline,
    "description": description,
    "vote_count": voteCount,
    "rating": rating,
  };
}
