class LikeUserModel {
  Like? like;
  TargetUser? target;

  LikeUserModel({this.like, this.target});

  ///Likes Users
  LikeUserModel.fromJsonLikeUser(Map<String, dynamic> json) {
    like = json['like'] != null ? new Like.fromJson(json['like']) : null;
    target = json['target'] != null ? new TargetUser.fromJson(json['target']) : null;
  }

  Map<String, dynamic> toJsonLikeUser() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.like != null) {
      data['like'] = this.like!.toJson();
    }
    if (this.target != null) {
      data['target'] = this.target!.toJson();
    }
    return data;
  }

  ///Users Likes Me
  LikeUserModel.fromJsonUserLikeMe(Map<String, dynamic> json) {
    like = json['like'] != null ? new Like.fromJson(json['like']) : null;
    target = json['source'] != null ? new TargetUser.fromJson(json['source']) : null;
  }

  Map<String, dynamic> toJsonUserLikeMe() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.like != null) {
      data['like'] = this.like!.toJson();
    }
    if (this.target != null) {
      data['source'] = this.target!.toJson();
    }
    return data;
  }
}

class Like {
  String? userId;
  String? likedUser;
  String? likedAt;

  Like({this.userId, this.likedUser, this.likedAt});

  Like.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    likedUser = json['liked_user'];
    likedAt = json['liked_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['liked_user'] = this.likedUser;
    data['liked_at'] = this.likedAt;
    return data;
  }
}

class TargetUser {
  String? id;
  String? username;
  String? mainProfile;
  String? mainProfileType;
  int? age;
  String? gender;

  TargetUser(
      {this.id,
        this.username,
        this.mainProfile,
        this.mainProfileType,
        this.age,
        this.gender});

  TargetUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    mainProfile = json['main_profile'];
    mainProfileType = json['main_profile_type'];
    age = json['age'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['main_profile'] = this.mainProfile;
    data['main_profile_type'] = this.mainProfileType;
    data['age'] = this.age;
    data['gender'] = this.gender;
    return data;
  }
}