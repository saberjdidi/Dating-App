class UserChatModel {
  final String id;
  final String fullName;
  final bool isConnect;
  final DateTime lastSeen;
  final String lastMessage;
  final String? file; // image ou vidéo
  final bool isRead;
  final bool isArchived;

  UserChatModel({
    required this.id,
    required this.fullName,
    required this.isConnect,
    required this.lastSeen,
    required this.lastMessage,
    this.file,
    this.isRead = true,
    this.isArchived = false,
  });

  // Pour afficher le "depuis combien de temps"
  String timeAgo() {
    final diff = DateTime.now().difference(lastSeen);
    if (diff.inMinutes < 60) return "  منذ${diff.inMinutes} دقيقة ";
    if (diff.inHours < 24) return " منذ${diff.inHours} ساعة ";
    return " منذ${diff.inDays} أيام ";
  }

  static UserChatModel empty() => UserChatModel(id: '', fullName: '', lastMessage: '', isConnect: false, isRead: false, lastSeen: DateTime.now());

/*  String timeAgo() {
    final diff = DateTime.now().difference(lastSeen);
    if (diff.inMinutes < 60) return "${diff.inMinutes} min ago";
    if (diff.inHours < 24) return "${diff.inHours} hrs ago";
    return "${diff.inDays} days ago";
  } */
}
 