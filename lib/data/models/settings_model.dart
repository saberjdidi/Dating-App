class SettingsModel {
  String? userId;
  String? targetUserId;
  bool? allowAudio;
  bool? allowVideo;
  bool? hideOnline;
  String? updatedAt;

  SettingsModel(
      {this.userId,
        this.targetUserId,
        this.allowAudio,
        this.allowVideo,
        this.hideOnline,
        this.updatedAt});

  SettingsModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    targetUserId = json['target_user_id'];
    allowAudio = json['allow_audio'];
    allowVideo = json['allow_video'];
    hideOnline = json['hide_online'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['target_user_id'] = this.targetUserId;
    data['allow_audio'] = this.allowAudio;
    data['allow_video'] = this.allowVideo;
    data['hide_online'] = this.hideOnline;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}