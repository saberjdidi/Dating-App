class StatsModel {
  int? likesGiven;
  int? likesReceived;
  int? mutualLikes;
  int? favouritesCount;

  StatsModel(
      {this.likesGiven,
        this.likesReceived,
        this.mutualLikes,
        this.favouritesCount});

  StatsModel.fromJson(Map<String, dynamic> json) {
    likesGiven = json['likes_given'];
    likesReceived = json['likes_received'];
    mutualLikes = json['mutual_likes'];
    favouritesCount = json['favourites_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['likes_given'] = this.likesGiven;
    data['likes_received'] = this.likesReceived;
    data['mutual_likes'] = this.mutualLikes;
    data['favourites_count'] = this.favouritesCount;
    return data;
  }
}