import 'package:dating_app_bilhalal/core/utils/enums.dart';

class AttachmentModel {
  final MessageType type;
  final String path; // local path or remote URL
  final String? name; // optional file name
  //final int? size; // bytes

  AttachmentModel({
    required this.type,
    required this.path,
    this.name,
    //this.size,
  });

  Map<String, dynamic> toJson() => {
    'type': type.toString().split('.').last,
    'path': path,
    'name': name,
    //'size': size,
  };

  static AttachmentModel fromJson(Map<String, dynamic> json) => AttachmentModel(
    type: MessageType.values.firstWhere((e) => e.toString().split('.').last == (json['type'] ?? 'text')),
    path: json['path'] ?? '',
    name: json['name'],
    //size: json['size'],
  );
}