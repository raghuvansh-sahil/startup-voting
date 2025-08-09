class VoteUpdateRequest {
  int id;
  int voteChange;

  VoteUpdateRequest({required this.id, required this.voteChange});

  factory VoteUpdateRequest.fromJson(Map<String, dynamic> json) =>
      VoteUpdateRequest(id: json["id"], voteChange: json["vote_change"]);

  Map<String, dynamic> toJson() => {"id": id, "vote_change": voteChange};
}
