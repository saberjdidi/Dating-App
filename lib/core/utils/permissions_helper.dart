import 'package:permission_handler/permission_handler.dart';

class PermissionsHelper {
  static Future<bool> requestMediaPermissions() async {
    final statuses = await [
      Permission.camera,
      Permission.photos,
      //Permission.storage,
    ].request();

    return statuses.values.every((status) => status.isGranted);
  }

  static Future<bool> requestCallPermissions({bool isVideo = false}) async {
    final permissions = <Permission>[
      Permission.microphone,
      if (isVideo) Permission.camera,
    ];

    final statuses = await permissions.request();
    return statuses.values.every((status) => status.isGranted);
  }
}