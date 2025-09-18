import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/user_chat_model.dart';

class DiscussionDetailsController extends GetxController {
  static DiscussionDetailsController get instance => Get.find();

  UserChatModel userChatModel  = Get.arguments['ChatDiscussion'] ?? UserChatModel.empty();
}