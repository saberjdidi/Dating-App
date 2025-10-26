class ProfileModel {
  String? userId;
  String? socialState;
  String? marriageType;
  String? description;
  String? jobTitle;
  String? salaryRangeMin;
  String? salaryRangeMax;
  String? idCountry;
  String? country;
  String? skinToneHex;

  ProfileModel({
    this.userId,
    this.socialState,
    this.marriageType,
    this.description,
    this.jobTitle,
    this.salaryRangeMin,
    this.salaryRangeMax,
    this.idCountry,
    this.country,
    this.skinToneHex
  });

  ProfileModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    socialState = json['social_state'];
    marriageType = json['marriage_type'];
    description = json['description'];
    jobTitle = json['job_title'];
    salaryRangeMin = json['salary_range_min'];
    salaryRangeMax = json['salary_range_max'];
    idCountry = json['country_id'];
    country = json['raw_country'];
    //country = json['country'];
    skinToneHex = json['skin_tone_hex'] != null ? json['skin_tone_hex'] : "#FFFFFF";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['social_state'] = this.socialState;
    data['marriage_type'] = this.marriageType;
    data['description'] = this.description;
    data['job_title'] = this.jobTitle;
    data['salary_range_min'] = this.salaryRangeMin;
    data['salary_range_max'] = this.salaryRangeMax;
    data['country_id'] = this.idCountry;
    data['skin_tone_hex'] = this.skinToneHex;
    return data;
  }
}