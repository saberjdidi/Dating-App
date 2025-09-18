import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/discussion_screen/controller/discussion_controller.dart';
import 'package:dating_app_bilhalal/presentation/discussion_screen/controller/discussion_details_controller.dart';

class DiscussionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DiscussionController());
    Get.lazyPut(() => DiscussionDetailsController());
  }
}