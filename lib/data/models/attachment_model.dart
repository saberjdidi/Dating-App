import 'dart:io';
import 'package:dating_app_bilhalal/core/utils/enums.dart';

class AttachmentModel {
  final MessageType type;
  final String? url; // local path or remote URL
  final File? file; // local path or remote URL
  final String? name; // optional file name
  //final int? size; // bytes

  AttachmentModel({
    required this.type,
     this.url,
    this.file,
    this.name,
    //this.size,
  });

  Map<String, dynamic> toJson() => {
    'type': type.toString().split('.').last,
    'url': url,
    'name': name,
    //'size': size,
  };

  static AttachmentModel fromJson(Map<String, dynamic> json) => AttachmentModel(
    type: MessageType.values.firstWhere((e) => e.toString().split('.').last == (json['type'] ?? 'text')),
    url: json['url'] ?? '',
    name: json['name'],
    //size: json['size'],
  );
}