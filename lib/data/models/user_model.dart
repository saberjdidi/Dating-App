import 'package:dating_app_bilhalal/data/models/profile_model.dart';

import 'stats_model.dart';

class UserModel {
  String? id;
  String? username;
  int? age;
  String? gender;
  String? country;
  String? socialState;
  String? mainProfile;
  String? jobTitle;
  String? description;
  int? score;

  String? email;
  int? height;
  int? weight;
  String? mainProfileType;
  bool? isActive;
  String? googleId;
  ProfileModel? profile;
  StatsModel? stats;

 //static
  String? imageProfile;
  String? fullName;
  String? bio;
  List<String>? interests;
  List<String>? images;
  bool? isFavoris;

  UserModel({
    this.id,
    this.username,
    this.age,
    this.gender,
    this.country,
    this.socialState,
    this.mainProfile,
    this.jobTitle,
    this.description,
    this.score,

    this.email,
    this.height,
    this.weight,
    this.mainProfileType,
    this.isActive,
    this.googleId,
    this.profile,
    this.stats,

    //static
     this.imageProfile,
     this.fullName,
     this.bio,
    this.interests,
    this.images,
    this.isFavoris,
  });

  static UserModel empty() => UserModel(id: '',imageProfile: '', username: '', bio: '', age: 18);

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    age = json['age'];
    gender = json['gender'];
    country = json['country'];
    socialState = json['social_state'];
    mainProfile = json['main_profile'];
    jobTitle = json['job_title'];
    description = json['description'];
    score = json['score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['age'] = this.age;
    data['gender'] = this.gender;
    data['country'] = this.country;
    data['social_state'] = this.socialState;
    data['main_profile'] = this.mainProfile;
    data['job_title'] = this.jobTitle;
    data['description'] = this.description;
    data['score'] = this.score;
    return data;
  }

  ///Profile details Start
  UserModel.fromJsonProfile(Map<String, dynamic> json) {
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
    googleId = json['google_id'];
    profile = json['profile'] != null ? new ProfileModel.fromJson(json['profile']) : null;
    stats = json['stats'] != null ? new StatsModel.fromJson(json['stats']) : null;
  }

  Map<String, dynamic> toJsonProfile() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['age'] = this.age;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['gender'] = this.gender;
    data['main_profile'] = this.mainProfile;
    data['main_profile_type'] = this.mainProfileType;
    //data['created_at'] = this.createdAt;
    //data['updated_at'] = this.updatedAt;
    data['is_active'] = this.isActive;
    data['google_id'] = this.googleId;
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    data['profile'] = this.profile;
    if (this.stats != null) {
      data['stats'] = this.stats!.toJson();
    }
    return data;
  }
///Profile details End
}