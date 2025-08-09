class AIResponse {
  String startupName;
  String tagline;
  String description;
  int voteCount;
  double rating;
  String explanation;

  AIResponse({
    required this.startupName,
    required this.tagline,
    required this.description,
    required this.voteCount,
    required this.rating,
    required this.explanation,
  });

  factory AIResponse.fromJson(Map<String, dynamic> json) => AIResponse(
    startupName: json["startup_name"],
    tagline: json["tagline"],
    description: json["description"],
    voteCount: json["vote_count"],
    rating: json["rating"],
    explanation: json["explanation"],
  );

  Map<String, dynamic> toJson() => {
    "startup_name": startupName,
    "tagline": tagline,
    "description": description,
    "vote_count": voteCount,
    "rating": rating,
    "explanation": explanation,
  };
}
