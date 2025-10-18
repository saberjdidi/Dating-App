import 'dart:io';

import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/network_manager.dart';
import 'package:dating_app_bilhalal/core/utils/permissions_helper.dart';
import 'package:dating_app_bilhalal/data/models/attachment_model.dart';
import 'package:dating_app_bilhalal/data/models/media_model.dart';
import 'package:dating_app_bilhalal/data/repositories/media_repository.dart';
import 'package:dating_app_bilhalal/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MediaOwnerProfileController extends GetxController {
  static MediaOwnerProfileController get instance => Get.find();

  final mediaRepository = MediaRepository();
  //RxList<MediaModel> mediaList = <MediaModel>[].obs;// ✅ depuis serveur
  RxList<File> selectedMedia = <File>[].obs;          // ✅ fichiers locaux
  RxBool isDataProcessing = false.obs;
  RxList<MediaModel> allMedia = <MediaModel>[].obs;

  Rx<List<String>> ListImages = Rx(
      [
        ImageConstant.profile1, ImageConstant.profile2, ImageConstant.profile3, ImageConstant.profile4, ImageConstant.profile5, ImageConstant.profile6, ImageConstant.profile7
      ]
  );

  final ImagePicker _picker = ImagePicker();
  //final RxList<AttachmentModel> allMedia = <AttachmentModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    getAllMedia();

   /* allMedia.addAll([
      AttachmentModel(type: MessageType.image, url: ImageConstant.profile2),
      AttachmentModel(type: MessageType.image, url: ImageConstant.profile7),
    ]); */
  }

  Future<void> getAllMedia() async {
    try {
      isDataProcessing.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isDataProcessing.value = false;
        MessageSnackBar.customToast(message: 'Pas de connexion Internet');
        return;
      }

      final result = await mediaRepository.getAllMedia();

      if (result.success) {
        allMedia.assignAll(result.data ?? []);
        debugPrint('✅ ${allMedia.length} médias chargés');
      } else {
        MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? '');
      }
    } catch (e) {
      MessageSnackBar.errorSnackBar(title: 'خطأ', message: e.toString());
    } finally {
      isDataProcessing.value = false;
    }
  }

  /// 🔹 Supprimer un média
  Future<void> deleteMedia(String id) async {
    final result = await mediaRepository.deleteMedia(id);
    if (result.success) {
      allMedia.removeWhere((m) => m.id == id);
      MessageSnackBar.successSnackBar(title: 'تم', message: result.message ?? 'تم حذف الوسائط بنجاح');
    } else {
      MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? 'فشل حذف الوسائط');
    }
  }

  Future<void> removeMedia(int index) async {
    final media = allMedia[index];
    if (media.file != null) {
      // ✅ local
      allMedia.removeAt(index);
    } else {
      // ✅ distant
      final result = await mediaRepository.deleteMedia(media.id);
      if (result.success) {
        allMedia.removeAt(index);
        MessageSnackBar.successSnackBar(title: 'تم', message: result.message ?? 'تم الحذف');
      } else {
        MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? '');
      }
    }
  }

  /// ✅ Upload des nouveaux médias
  Future<void> createMedia() async {
    // ✅ Vérifier qu'au moins une image a été ajoutée
    if (selectedMedia.isEmpty) {
      MessageSnackBar.customToast(message: 'الرجاء تحميل صورة واحدة على الأقل');
      return;
    }
    try {
      isDataProcessing.value = true;

      // ✅ Vérifier la connexion internet
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        isDataProcessing.value = false;
        MessageSnackBar.customToast(message: 'No Internet Connection');
        return;
      }

      for (int i = 0; i < selectedMedia.length; i++) {
        final file = selectedMedia[i];
        final uploadResult = await mediaRepository.uploadOneMedia(file);

        if (!uploadResult.success) {
          isDataProcessing.value = false;
          // ⚠️ Si erreur : afficher un message d’erreur pour ce fichier
          MessageSnackBar.errorSnackBar(
            title: 'خطأ',
            message: 'فشل تحميل الصورة رقم ${i + 1}: ${uploadResult.message ?? ''}',
          );
        }
       /* else {
          MessageSnackBar.successSnackBar(
            title: 'تم',
            message: 'تم تحميل الصورة رقم ${i + 1} بنجاح',
          );
        } */

        // ✅ Si c’est le dernier fichier ET upload réussi → afficher message de succès
        if (uploadResult.success && i == selectedMedia.length - 1) {
          Get.offAllNamed(Routes.successAccountScreen);
          isDataProcessing.value = false;
          MessageSnackBar.successSnackBar(title: 'تم', message: uploadResult.message ?? 'تم تحميل جميع الصور بنجاح',);
        }
        selectedMedia.clear(); // ✅ vider la liste locale après succès
        await getAllMedia();   // ✅ rafraîchir depuis le serveur
      }
    }
    catch (exception) {
      isDataProcessing.value = false;
      debugPrint('Exception : ${exception.toString()}');
      //FullScreenLoader.stopLoading();
      //Show some generic error to the user
      MessageSnackBar.errorSnackBar(title: 'Oh Snap!', message: exception.toString());
    } finally {
      isDataProcessing.value = false;
    }
  }

  /// ✅ Choisir média (photo ou vidéo)
  Future<void> showBottomSheetMedia(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await showModalBottomSheet<XFile?>(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Gallery"),
              onTap: () async {
                Navigator.pop(context);
                await pickMedia(context, ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () async {
                Navigator.pop(context);
                await pickMedia(context, ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ Pick depuis la galerie/caméra
  Future<void> pickMedia(BuildContext context, ImageSource source) async {
    final hasPermission = await PermissionsHelper.requestMediaPermissions();
    if (!hasPermission) {
      Get.snackbar("Permission Denied", "You need to grant permissions to continue.");
      return;
    }

    if (selectedMedia.length >= 5) {
      showMaxPhotosDialog(context);
      return;
    }


    ///Personalize Files without model
    if (selectedMedia.length >= 5) {
      // Afficher le dialog si dépasse 5
      showMaxPhotosDialog(context);
      return;
    }
    XFile? file;
    if (source == ImageSource.camera) {
      file = await _picker.pickImage(source: ImageSource.camera);
    } else {
      file = await _picker.pickMedia();
    }

    if (file != null) {
      selectedMedia.add(File(file.path)); // ✅ ajout local instantané
    }
  }

  /// ✅ Supprimer localement un média sélectionné avant upload
 /* void removeMedia(int index) {
    allMedia.removeAt(index);
    selectedMedia.removeAt(index);
  } */

  /// ✅ Dialog quand dépasse la limite
  void showMaxPhotosDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (builder) => CustomDialog(
        icon: Icons.close,
        onCancel: () {Get.back();},
        //onCancel: () => Navigator.pop(context),
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