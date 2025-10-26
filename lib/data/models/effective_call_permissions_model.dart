class EffectiveCallPermissionsModel {
  String? userId;
  String? viewerId;
  EffectiveCall? effectiveCall;
  OnlineVisibility? onlineVisibility;

  EffectiveCallPermissionsModel({
    this.userId,
    this.viewerId,
    this.effectiveCall,
    this.onlineVisibility,
  });

  EffectiveCallPermissionsModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    viewerId = json['viewer_id'];
    effectiveCall = json['effective_call'] != null
        ? EffectiveCall.fromJson(json['effective_call'])
        : null;
    onlineVisibility = json['online_visibility'] != null
        ? OnlineVisibility.fromJson(json['online_visibility'])
        : null;
  }
}

class EffectiveCall {
  bool? allowAudio;
  bool? allowVideo;
  String? source;

  EffectiveCall({this.allowAudio, this.allowVideo, this.source});

  EffectiveCall.fromJson(Map<String, dynamic> json) {
    allowAudio = json['allow_audio'];
    allowVideo = json['allow_video'];
    source = json['source'];
  }
}

class OnlineVisibility {
  bool? visible;
  String? source;

  OnlineVisibility({this.visible, this.source});

  OnlineVisibility.fromJson(Map<String, dynamic> json) {
    visible = json['visible'];
    source = json['source'];
  }
}