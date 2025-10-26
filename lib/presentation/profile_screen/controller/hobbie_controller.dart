import 'package:dating_app_bilhalal/core/utils/helpers/helper_functions.dart';
import 'package:dating_app_bilhalal/core/utils/image_constant.dart';
import 'package:dating_app_bilhalal/core/utils/message_snackbar.dart';
import 'package:dating_app_bilhalal/core/utils/network_manager.dart';
import 'package:dating_app_bilhalal/data/models/interest_model.dart';
import 'package:dating_app_bilhalal/data/repositories/profile_repository.dart';
import 'package:dating_app_bilhalal/theme/custom_text_style.dart';
import 'package:dating_app_bilhalal/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'edit_profile_controller.dart';

class HobbieController extends GetxController {
  static HobbieController get instance => Get.find();

  final profileRepository = ProfileRepository();
  RxBool isDataProcessing = false.obs;
  RxList<InterestModel> selectedHobbies = <InterestModel>[].obs;


  @override
  void onInit() {
    super.onInit();
    getMyHobbies();
  }

/*  Future<void> getUserHobbies() async {
    await Future.delayed(const Duration(seconds: 1));
    final apiHobbies = [
      InterestModel(name: "التسوق", icon: Icons.shopping_bag_outlined),
      InterestModel(name: "فوتوغرافيا", icon: Icons.camera_alt_outlined),
    ];
    selectedHobbies.assignAll(apiHobbies);
  } */
  Future<void> getMyHobbies() async {
    try {
      isDataProcessing.value = true;
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isDataProcessing.value = false;
        MessageSnackBar.customToast(message: 'No internet connection');
        return;
      }

      final result = await profileRepository.getMyHobbies();
      if (result.success) {
        // Liste brute venant de l’API (en anglais)
        final apiHobbies = result.data ?? [];

        // Conversion anglaise → arabe et mappage avec les icônes locales
        final mappedHobbies = apiHobbies.map((apiHobby) {
          final arabicName = THelperFunctions.getInterestArabic(apiHobby.name ?? '');

          final match = interestsList.value.firstWhere(
                (local) => local.name == arabicName,
            orElse: () => InterestModel(name: arabicName, icon: Icons.help_outline),
          );
          return match;
        }).toList();

        selectedHobbies.assignAll(mappedHobbies);
        debugPrint('✅ ${selectedHobbies.length} hobbies mappés et convertis');
      } else {
        MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? '');
      }
    } catch (e) {
      MessageSnackBar.errorSnackBar(title: 'خطأ', message: e.toString());
    } finally {
      isDataProcessing.value = false;
    }
  }

  void toggleHobby(InterestModel hobby, BuildContext context) {
    if (selectedHobbies.contains(hobby)) {
      if (selectedHobbies.length < 2) {
        MessageSnackBar.informationToast(title: 'خطأ', message: "يجب اضافة اهتمام على الاقل");
        return;
      }
      selectedHobbies.remove(hobby);
    } else {
      if (selectedHobbies.length >= 5) {
        showMaxInterestDialog(context);
        return;
      }
      selectedHobbies.add(hobby);
    }
  }

  Future<void> addHobbies() async {
    try {
      isDataProcessing.value = true;
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isDataProcessing.value = false;
        MessageSnackBar.customToast(message: 'No internet connection');
        return;
      }

      // ✅ Convertir les intérêts en anglais avant l’envoi
      final hobbiesInEnglish = selectedHobbies
          .map((item) => THelperFunctions.getInterestEnum(item.name!))
          .toList();
      final result = await profileRepository.addHobbiesList(hobbiesInEnglish);
      //final result = await profileRepository.addHobbiesList(selectedInterests.toList());

      //final selectedNames = hobbiesList.map((e) => e.name!).toList();
      //final result = await profileRepository.addHobbiesList(selectedNames);

      if (result.success) {
        //selectedHobbies.assignAll(result.data ?? []);
        MessageSnackBar.successSnackBar(title: 'تم', message: result.message ?? '');
      } else {
        MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? '');
      }
    } catch (e) {
      MessageSnackBar.errorSnackBar(title: 'خطأ', message: e.toString());
    } finally {
      isDataProcessing.value = false;
    }
  }

  /// Méthode pour afficher le dialog
  void showMaxInterestDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (builder) => CustomDialog(
        icon: Icons.close,
        onCancel: () => Navigator.pop(context),
        onTap: () {},
        showSuccessButton: false,
        //successText: "يقبل".tr,
        title: "يمكنك إضافة 5 اهتمامات فقط".tr,
        description: "أضف فقط 5 اهتمامات تتناسب بشكل أفضل مع شخصيتك.".tr,
        descriptionTextStyle: CustomTextStyles.titleSmallGray400,
        image: ImageConstant.imgWarning,
      ),
    );
  }

}
