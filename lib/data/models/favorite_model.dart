class FavoriteModel {
  String? userId;
  String? mediaId;
  String? addedAt;
  MediaFavorite? media;

  FavoriteModel({this.userId, this.mediaId, this.addedAt, this.media});

  FavoriteModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    mediaId = json['media_id'];
    addedAt = json['added_at'];
    media = json['media'] != null ? new MediaFavorite.fromJson(json['media']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['media_id'] = this.mediaId;
    data['added_at'] = this.addedAt;
    if (this.media != null) {
      data['media'] = this.media!.toJson();
    }
    return data;
  }
}

class MediaFavorite {
  String? id;
  String? ownerUserId;
  String? ownerUsername;
  String? mediaPath;
  String? mediaType;
  String? mediaUrl;
  int? favouriteCount;

  MediaFavorite(
      {this.id,
        this.ownerUserId,
        this.ownerUsername,
        this.mediaPath,
        this.mediaType,
        this.mediaUrl,
        this.favouriteCount});

  MediaFavorite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerUserId = json['owner_user_id'];
    ownerUsername = json['owner_username'];
    mediaPath = json['media_path'];
    mediaType = json['media_type'];
    mediaUrl = json['media_url'];
    favouriteCount = json['favourite_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['owner_user_id'] = this.ownerUserId;
    data['owner_username'] = this.ownerUsername;
    data['media_path'] = this.mediaPath;
    data['media_type'] = this.mediaType;
    data['media_url'] = this.mediaUrl;
    data['favourite_count'] = this.favouriteCount;
    return data;
  }
}