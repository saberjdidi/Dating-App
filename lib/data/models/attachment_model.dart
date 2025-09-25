import 'dart:io';
import 'package:dating_app_bilhalal/core/utils/enums.dart';

class AttachmentModel {
  final MessageType type;
  final String? url; // local path or remote URL
  final File? file; // local path or remote URL
  final String? name; // optional file name
  final Duration? duration; // important pour audio
  //final int? size; // bytes

  AttachmentModel({
    required this.type,
     this.url,
    this.file,
    this.name,
    this.duration,
    //this.size,
  });

  Map<String, dynamic> toJson() => {
    'type': type.toString().split('.').last,
    'url': url,
    'name': name,
    'duration': duration?.inMilliseconds,
    //'size': size,
  };

  static AttachmentModel fromJson(Map<String, dynamic> json) => AttachmentModel(
    type: MessageType.values.firstWhere((e) => e.toString().split('.').last == (json['type'] ?? 'text')),
    url: json['url'] ?? '',
    name: json['name'],
    duration: json['duration'] != null ? Duration(milliseconds: json['duration']) : null,
    //size: json['size'],
  );
}