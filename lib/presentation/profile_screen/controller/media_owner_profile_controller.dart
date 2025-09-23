import 'dart:io';

import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/permissions_helper.dart';
import 'package:dating_app_bilhalal/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MediaOwnerProfileController extends GetxController {
  static MediaOwnerProfileController get instance => Get.find();

  final GlobalKey<FormState> formMediaProfileKey = GlobalKey<FormState>();

  Rx<List<String>> ListImages = Rx(
      [
        ImageConstant.profile1, ImageConstant.profile2, ImageConstant.profile3, ImageConstant.profile4, ImageConstant.profile5, ImageConstant.profile6, ImageConstant.profile7
      ]
  );

  final ImagePicker _picker = ImagePicker();
  final RxList<File> selectedMedia = <File>[].obs;

  Future<void> pickMedia(BuildContext context, ImageSource source) async {
    final hasPermission = await PermissionsHelper.requestMediaPermissions();
    if (!hasPermission) {
      Get.snackbar("Permission Denied", "You need to grant permissions to continue.");
      return;
    }

    if (selectedMedia.length >= 5) {
      // Afficher le dialog si dépasse 5
      showMaxPhotosDialog(context);
      return;
    }

    if(source == ImageSource.camera) {
      XFile? file = await ImagePicker().pickImage(source: ImageSource.camera);

      if (file != null) {
        selectedMedia.add(File(file.path));
      }
    } else {
      XFile? file = await ImagePicker().pickMedia();

      if (file != null) {
        selectedMedia.add(File(file.path));
      }
    }


    //pick multi files
  /*  final List<XFile>? files = await _picker.pickMultiImage();

    if (files!.length >= 5) {
      // Afficher le dialog si dépasse 5
      showMaxPhotosDialog(context);
      return;
    }

    if (files != null) {
      selectedMedia.addAll(files.map((f) => File(f.path)));
    } */
  }

  void removeMedia(int index) {
    selectedMedia.removeAt(index);
  }

  /// Méthode pour afficher le dialog
  void showMaxPhotosDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (builder) => CustomDialog(
        icon: Icons.close,
        onCancel: () => Navigator.pop(context),
        onTap: () {},
        showSuccessButton: false,
        //successText: "يقبل".tr,
        title: "يمكنك تحميل 5 صور فقط.".tr,
        description: "أضف فقط 5 صور.".tr,
        descriptionTextStyle: CustomTextStyles.titleSmallGray400,
        image: ImageConstant.imgWarning,
      ),
    );
  }

}