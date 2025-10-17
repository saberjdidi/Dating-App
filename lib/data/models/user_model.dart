import 'package:dating_app_bilhalal/data/models/profile_model.dart';

import 'stats_model.dart';

class UserModel {
  int? id;
  String? username;
  String? email;
  int? age;
  int? height;
  int? weight;
  int? gender;
  String? mainProfile;
  String? mainProfileType;
  String? createdAt;
  String? updatedAt;
  bool? isActive;
  String? googleId;
  ProfileModel? profile;
  StatsModel? stats;


  String? imageProfile;
  String? fullName;
  String? bio;
  List<String>? interests;
  List<String>? images;
  bool? isFavoris;

  UserModel({
    this.id,
    this.username,
    this.email,
    this.age,
    this.height,
    this.weight,
    this.gender,
    this.mainProfile,
    this.mainProfileType,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.googleId,
    this.profile,
    this.stats,

     this.imageProfile,
     this.fullName,
     this.bio,
    this.interests,
    this.images,
    this.isFavoris,
  });

  static UserModel empty() => UserModel(imageProfile: '', fullName: '', bio: '', age: 10, isFavoris: false, interests: [], images: []);

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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isActive = json['is_active'];
    googleId = json['google_id'];
    profile = json['profile'] != null ? new ProfileModel.fromJson(json['profile']) : null;
    stats = json['stats'] != null ? new StatsModel.fromJson(json['stats']) : null;
  }

  Map<String, dynamic> toJson() {
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
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
}