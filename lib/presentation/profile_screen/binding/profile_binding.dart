import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/filter_screen/controller/filter_controller.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/controller/edit_profile_controller.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/controller/media_owner_profile_controller.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/controller/profile_controller.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/controller/profile_details_controller.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/controller/user_owner_profile_controller.dart';

/// A binding class for the OnboardingOneScreen.
///
/// This class ensures that the OnboardingOneController is created when the
/// OnboardingOneScreen is first loaded.
class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => ProfileDetailsController());
    Get.lazyPut(() => UserOwnerProfileController());
    Get.lazyPut(() => MediaOwnerProfileController());
    Get.lazyPut(() => EditProfileController());
  }
}