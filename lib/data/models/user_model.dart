import 'package:dating_app_bilhalal/data/models/profile_model.dart';

import 'stats_model.dart';

class UserModel {
  String? id;
  String? username;
  int? age;
  String? gender;
  //String? country;
  String? socialState;
  String? mainProfile;
  String? jobTitle;
  String? description;
  int? score;

  String? email;
  int? height;
  int? weight;
  String? skinToneHex;
  String? mainProfileType;
  bool? isActive;
  //String? googleId;
  ProfileModel? profile;
  StatsModel? stats;

 //static
  String? imageProfile;
  String? fullName;
  String? bio;
  List<String>? interests;
  List<String>? images;
  bool? isFavoris;
  DateTime? lastSeenAt;

  UserModel({
    this.id,
    this.username,
    this.age,
    this.gender,
    //this.country,
    this.socialState,
    this.mainProfile,
    this.jobTitle,
    this.description,
    this.score,

    this.email,
    this.height,
    this.weight,
    this.skinToneHex,
    this.mainProfileType,
    this.isActive,
    //this.googleId,
    this.profile,
    this.stats,
    this.lastSeenAt,

    //static
   /*  this.imageProfile,
     this.fullName,
     this.bio,
    this.interests,
    this.images,
    this.isFavoris, */
  });

  static UserModel empty() => UserModel(id: '',mainProfile: '', username: '', gender: '', age: 18);

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    age = json['age'];
    height = json['height'];
    weight = json['weight'];
    gender = json['gender'];
    mainProfile = json['main_profile'];
    mainProfileType = json['main_profile_type'];
    //createdAt = json['created_at'];
    //updatedAt = json['updated_at'];
    isActive = json['is_active'];
    //googleId = json['google_id'];
    profile = json['profile'] != null ? new ProfileModel.fromJson(json['profile']) : null;
    stats = json['stats'] != null ? new StatsModel.fromJson(json['stats']) : null;
  }

 /* UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    age = json['age'];
    gender = json['gender'];
    //country = json['country'];
    socialState = json['social_state'];
    mainProfile = json['main_profile'];
    jobTitle = json['job_title'];
    description = json['description'];
    score = json['score'];
    height = json['height'];
    weight = json['weight'];
    skinToneHex = json['skin_tone_hex'] != null ? json['skin_tone_hex'] : "#e0cda9";
    lastSeenAt = DateTime.tryParse(json['lastSeenAt']);
  } */

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['age'] = this.age;
    data['gender'] = this.gender;
    //data['country'] = this.country;
    data['social_state'] = this.socialState;
    data['main_profile'] = this.mainProfile;
    data['job_title'] = this.jobTitle;
    data['description'] = this.description;
    data['score'] = this.score;
    return data;
  }

  /// Check if user was active within last 24 hours
  bool get isRecentlyActive {
    if (lastSeenAt == null) return false;
    final difference = DateTime.now().difference(lastSeenAt!);
    return difference.inHours < 24;
  }

}