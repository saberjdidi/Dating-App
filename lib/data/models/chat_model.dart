class ChatModel {
  final String? senderUid;
  final String? recipientUid;
  final String? senderFullName;
  final String? recipientFullName;
  final bool isConnect;
  final DateTime createdAt;
  final String recentTextMessage;
  final bool isRead;
  final bool isArchived;
  final String? senderProfile;
  final String? recipientProfile;
  final num? totalUnReadMessages;

  ChatModel({
    this.senderUid,
    this.recipientUid,
    this.senderFullName,
    this.recipientFullName,
    required this.isConnect,
    required this.createdAt,
    required this.recentTextMessage,
    this.isRead = true,
    this.isArchived = false,
    this.senderProfile,
    this.recipientProfile,
    this.totalUnReadMessages
  });

  // Pour afficher le "depuis combien de temps"
  String timeAgo() {
    final diff = DateTime.now().difference(createdAt);
    if (diff.inMinutes < 60) return "  منذ${diff.inMinutes} دقيقة ";
    if (diff.inHours < 24) return " منذ${diff.inHours} ساعة ";
    return " منذ${diff.inDays} أيام ";
  }

  static ChatModel empty() => ChatModel(senderUid: '', senderFullName: '', recentTextMessage: '', senderProfile: '', isConnect: false, isRead: false, createdAt: DateTime.now());

  @override
  List<Object?> get props => [
    senderUid,
    recipientUid,
    senderFullName,
    recipientFullName,
    recentTextMessage,
    createdAt,
    senderProfile,
    recipientProfile,
    totalUnReadMessages
  ];

/*  String timeAgo() {
    final diff = DateTime.now().difference(lastSeen);
    if (diff.inMinutes < 60) return "${diff.inMinutes} min ago";
    if (diff.inHours < 24) return "${diff.inHours} hrs ago";
    return "${diff.inDays} days ago";
  } */
}
 