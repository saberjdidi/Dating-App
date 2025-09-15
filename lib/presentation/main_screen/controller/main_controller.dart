import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/UserModel.dart';

class MainController extends GetxController {
  static MainController get instance => Get.find();

  final RxList<UserModel> users = <UserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadUsers();
  }

  void loadUsers() {
    users.value = [
      UserModel(
        imageProfile: ImageConstant.imgOnBoarding1,
        fullName: 'نورا خالد',
        age: 25,
        bio: '🌍📸 نموذج احترافي',
      ),
      UserModel(
        imageProfile: ImageConstant.imgOnBoarding2,
        fullName: 'نورا خالد',
        age: 32,
        bio: 'مبرمج',
      ),
      UserModel(
        imageProfile: ImageConstant.imgOnBoarding3,
        fullName: 'ايلاف خالد',
        age: 29,
        bio: 'شخص إعلامي',
      ),
    ];
  }
}