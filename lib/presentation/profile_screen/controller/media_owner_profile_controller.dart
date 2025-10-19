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
  //RxList<File> selectedMedia = <File>[].obs;          // ✅ fichiers locaux
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
        // On garde les fichiers locaux déjà ajoutés
        final localMedia = allMedia.where((m) => m.file != null).toList();

        allMedia
          ..clear()
          ..addAll(localMedia) // garder les locaux
          ..addAll(result.data ?? []); // ajouter ceux du serveur
        //allMedia.assignAll(result.data ?? []);
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

  /// 🔹 Supprimer un média (local ou serveur)
  Future<void> removeMedia(int index) async {
    final media = allMedia[index];
    if (media.file != null) {
      // ✅ Local seulement
      allMedia.removeAt(index);
      return;
    } else {
      // ✅ Supprimer côté serveur
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
    final localFiles = allMedia.where((m) => m.file != null).toList();
    // ✅ Vérifier qu'au moins une image a été ajoutée
    if (localFiles.isEmpty) {
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

      for (int i = 0; i < localFiles.length; i++) {
        final file = localFiles[i].file!;
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
        if (uploadResult.success && i == localFiles.length - 1) {
          isDataProcessing.value = false;
          MessageSnackBar.successSnackBar(title: 'تم', message: uploadResult.message ?? 'تم تحميل الصور بنجاح',);
        }
        // ✅ Rafraîchir la liste depuis serveur
        await getAllMedia();
      }
    }
    catch (exception) {
      isDataProcessing.value = false;
      debugPrint('❌ Exception : ${exception.toString()}');
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

  /// ✅ Déterminer le type du média
  String _getMediaType(String path) {
    final ext = path.toLowerCase();
    if (ext.endsWith('.mp4') || ext.endsWith('.mov') || ext.endsWith('.avi')) {
      return 'video';
    }
    return 'image';
  }

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

  /// ✅ Pick depuis la galerie/caméra
  Future<void> pickMedia(BuildContext context, ImageSource source) async {
    final hasPermission = await PermissionsHelper.requestMediaPermissions();
    if (!hasPermission) {
      Get.snackbar(
          "Permission Denied", "You need to grant permissions to continue.");
      return;
    }

    if (allMedia
        .where((m) => m.file != null)
        .length >= 5) {
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
      // ✅ Vérifie si ce fichier est déjà présent (évite doublon)
      final alreadyExists = allMedia.any((m) => m.file?.path == file!.path);
      if (alreadyExists) return;

      final newMedia = MediaModel(
        id: '',
        // pas encore d'id (local)
        userId: '',
        mediaType: _getMediaType(file.path),
        mediaKey: '',
        mediaUrl: '',
        createdAt: '',
        updatedAt: '',
        favouriteCount: 0,
        file: File(file.path),
      );

      allMedia.insert(0, newMedia); // afficher en premier
    }
  }


  /// ✅ Supprimer localement un média sélectionné avant upload
 /* void removeMedia(int index) {
    allMedia.removeAt(index);
    selectedMedia.removeAt(index);
  } */



}