import 'dart:io';

import 'package:dating_app_bilhalal/core/utils/message_snackbar.dart';
import 'package:dating_app_bilhalal/core/utils/network_manager.dart';
import 'package:dating_app_bilhalal/core/utils/permissions_helper.dart';
import 'package:dating_app_bilhalal/data/repositories/media_repository.dart';
import 'package:dating_app_bilhalal/presentation/password_screen/password_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SupportController extends GetxController {
  static SupportController get instance => Get.find();
  var isRTL = true.obs;
  final GlobalKey<FormState> formSupportKey = GlobalKey<FormState>();
  final MediaRepository mediaRepository = MediaRepository();
  RxBool isDataProcessing = false.obs;

  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  //FocusNodes
  FocusNode subjectFocus = FocusNode();
  FocusNode messageFocus = FocusNode();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    subjectController.dispose();
    messageController.dispose();

    subjectFocus.dispose();
    messageFocus.dispose();
  }

  ///Max Length TextFormField Start
  /// --- Observables pour le compteur
  RxInt subjectRemaining = 20.obs;
  RxString subjectError = "".obs;

  /// --- Vérification compteur à chaque modification
  void onSubjectChanged(String value) {
    subjectRemaining.value = 20 - value.length;
    if (value.length > 20) {
      subjectError.value = "الموضوع لا يمكن أن يتجاوز 20 حرف.";
    } else {
      subjectError.value = "";
    }
  }

  RxInt messageRemaining = 100.obs;
  RxString messageError = "".obs;
  void onMessageChanged(String value) {
    messageRemaining.value = 100 - value.length;
    if (value.length > 100) {
      messageError.value = "الرسالة لا يمكن أن يتجاوز 100 حرف.";
    } else {
      messageError.value = "";
    }
  }
  ///Max Length TextFormField End

  ///Media Start
  final ImagePicker _picker = ImagePicker();
  final Rx<File?> selectedMedia = Rx<File?>(null);
  final RxString mediaType = ''.obs; // "image" ou "video"

  Future<void> pickMedia() async {
    final hasPermission = await PermissionsHelper.requestMediaPermissions();
    if (!hasPermission) {
      Get.snackbar("Permission Denied", "You need to grant permissions to continue.");
      return;
    }

    // Choix du média (image ou vidéo)
    final XFile? pickedFile = await _picker.pickMedia();

    if (pickedFile != null) {
      selectedMedia.value = File(pickedFile.path);
      final extension = pickedFile.path.split('.').last.toLowerCase();

      if (['mp4', 'mov', 'avi'].contains(extension)) {
        mediaType.value = "video";
      } else {
        mediaType.value = "image";
      }
    }
  }

  void removeMedia() {
    selectedMedia.value = null;
    mediaType.value = '';
  }

  ///Select many files
  /*
   final RxList<File> selectedMedia = <File>[].obs;

  Future<void> pickMedia() async {
    final hasPermission = await PermissionsHelper.requestMediaPermissions();
    if (!hasPermission) {
      Get.snackbar("Permission Denied", "You need to grant permissions to continue.");
      return;
    }

    final List<XFile>? files = await _picker.pickMultiImage();

    if (files != null) {
      selectedMedia.addAll(files.map((f) => File(f.path)));
    }
  }
   void removeMedia(int index) {
    selectedMedia.removeAt(index);
  }
   */
  /// Media End

  savedFn() async {
    try {

   final isValid = formSupportKey.currentState!.validate();
      if (!isValid) {
        return;
      }
   formSupportKey.currentState!.save();

   isDataProcessing.value = true;

   //Check internet connection
   final isConnected = await NetworkManager.instance.isConnected();
   if(!isConnected) {
     isDataProcessing.value = false;
     MessageSnackBar.customToast(message: 'No Internet Connection');
     return;
   }

   //Add One media
   final result = await mediaRepository
       .addSupport(file: selectedMedia.value, subject: subjectController.text.trim(), message: messageController.text.trim());
   if (result.success) {
     subjectController.clear();
     messageController.clear();
     selectedMedia.value = null;
     mediaType.value = '';
     MessageSnackBar.successSnackBar(title: 'تم', message: result.message ?? 'تم إرسال رسالة الدعم بنجاح');
     //isDataProcessing.value = false;
     final attachment = result.data?['attachment_url'];
     debugPrint("attachment : $attachment");
   } else {
     MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? '');
     isDataProcessing.value = false;
   }

   //Add many Media
  /* for (int i = 0; i < selectedMedia.length; i++) {
     final file = selectedMedia[i];
     final result = await mediaRepository
         .addSupport(file: file, subject: subjectController.text.trim(), message: messageController.text.trim());

     if (!result.success) {
       MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? '');
       isDataProcessing.value = false;
     }

     // ✅ Si c’est le dernier fichier ET upload réussi → afficher message de succès
     if (result.success && i == selectedMedia.length - 1) {
       MessageSnackBar.successSnackBar(title: 'تم', message: result.message ?? 'تم إرسال رسالة الدعم بنجاح');
       isDataProcessing.value = false;
       final attachment = result.data?['attachment_url'];
       debugPrint("attachment : $attachment");
       subjectController.clear();
       messageController.clear();
       selectedMedia.clear();
     }
   } */

    }
    catch (exception) {
      isDataProcessing.value = false;
      debugPrint('Exception : ${exception.toString()}');
    } finally {
      isDataProcessing.value = false;
    }
  }
}