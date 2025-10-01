import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/chat_screen/controller/chat_controller.dart';
import 'package:dating_app_bilhalal/presentation/chat_screen/controller/message_controller.dart';
import 'package:dating_app_bilhalal/presentation/chat_screen/controller/user_chat_profile_controller.dart';

class DiscussionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController());
    Get.lazyPut(() => MessageController());
    Get.lazyPut(() => UserChatProfileController());
  }
}