import 'dart:io';

class MediaModel {
  final String id;
  final String userId;
  final String mediaType;
  final String mediaKey;
  final String mediaUrl;
  final String createdAt;
  final String updatedAt;
  final int favouriteCount;
  final File? file; // local path

  MediaModel({
    required this.id,
    required this.userId,
    required this.mediaType,
    required this.mediaKey,
    required this.mediaUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.favouriteCount,
    this.file
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      id: json['id']?.toString() ?? '',
      userId: json['user_id']?.toString() ?? '',
      mediaType: json['media_type'] ?? '',
      mediaKey: json['media_key'] ?? '',
      mediaUrl: json['media_url'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      favouriteCount: json['favourite_count'] ?? 0,
    );
  }
}
