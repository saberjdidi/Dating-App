class PresenceModel {
  String? userId;
  DateTime? lastSeenAt;

  PresenceModel({this.userId, this.lastSeenAt});

  PresenceModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    lastSeenAt = DateTime.tryParse(json['lastSeenAt']);
  }

  /// Check if user was active within last 24 hours
  bool get isRecentlyActive {
    if (lastSeenAt == null) return false;
    final difference = DateTime.now().difference(lastSeenAt!);
    return difference.inHours < 24;
  }
}