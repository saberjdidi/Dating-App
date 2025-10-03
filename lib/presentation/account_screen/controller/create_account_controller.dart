import 'dart:io';

import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/permissions_helper.dart';
import 'package:dating_app_bilhalal/data/models/interest_model.dart';
import 'package:dating_app_bilhalal/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccountController extends GetxController {
  RxInt currentIndexStepper = 0.obs;

  final GlobalKey<FormState> formCreateAccountKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formOverviewAccountKey = GlobalKey<FormState>();

  ///ImStepper
  // REQUIRED: USED TO CONTROL THE STEPPER.
  RxInt activeStep = 0.obs; // Initial step set to 0.
  // OPTIONAL: can be set directly.
  RxInt dotCount = 4.obs;

  //final apiClient = Get.find<ApiClient>();

  final TextCounterController nameCounterController = Get.put(TextCounterController(100));

  TextEditingController fullNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController lookingForController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController paysController = TextEditingController();
  RxInt sexValue = 0.obs;
  RxDouble currentAgeValue = 20.toDouble().obs;
  RxDouble currentWeightValue = 50.toDouble().obs;
  RxDouble currentHeightValue = 170.toDouble().obs;
  var currentRangeValues = const RangeValues(177, 300).obs;
  //color
  RxString selectedColor = ''.obs;
  selectColor(String color) {
    selectedColor.value = color;
    debugPrint('color : $color');
  }

  ///Interest Start
  var selectedInterests = <String>[].obs;

   toggleInterest(String interest, BuildContext context) {
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
    } else {
      if (selectedInterests.length >= 5) {
        // Afficher le dialog si dépasse 5
        showMaxInterestDialog(context);
        return;
      }
      selectedInterests.add(interest);
    }

    debugPrint('interest : $selectedInterests');
  }

  ///Interest End

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Rx<bool> isShowPassword = true.obs;
  Rx<bool> isProcessing = false.obs;

  ///Max Length TextFormField Start
  /// --- Observables pour le compteur
  RxInt fullNameRemaining = 20.obs;
  RxString fullNameError = "".obs;

  /// --- Vérification compteur à chaque modification
  void onFullNameChanged(String value) {
    fullNameRemaining.value = 20 - value.length;
    if (value.length > 20) {
      fullNameError.value = "الاسم الكامل لا يمكن أن يتجاوز 20 حرف.";
    } else {
      fullNameError.value = "";
    }
  }

  RxInt bioRemaining = 100.obs;
  RxString bioError = "".obs;
  void onBioChanged(String value) {
    bioRemaining.value = 100 - value.length;
    if (value.length > 100) {
      bioError.value = "الاسم الكامل لا يمكن أن يتجاوز 100 حرف.";
    } else {
      bioError.value = "";
    }
  }

  RxInt jobRemaining = 50.obs;
  RxString jobError = "".obs;
  void onJobChanged(String value) {
    jobRemaining.value = 50 - value.length;
    if (value.length > 50) {
      jobError.value = "الاسم الكامل لا يمكن أن يتجاوز 50 حرف.";
    } else {
      jobError.value = "";
    }
  }
  ///Max Length TextFormField End

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    bioController.dispose();
    super.onClose();
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

  //Images
  final ImagePicker _picker = ImagePicker();
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

  ///Upload user profile start
  /// Fichier sélectionné (image de profil)
  final Rx<File?> selectedImage = Rx<File?>(null);

  /// Mettre à jour l'image sélectionnée
  void setImage(File? image) {
    selectedImage.value = image;
  }

  /// Effacer l'image sélectionnée
  void clearImage() {
    selectedImage.value = null;
  }

 /* void _submitForm() {
    final imageFile = selectedImage.value;
    if (imageFile != null) {
      print("Image prête à envoyer : ${imageFile.path}");
      // Envoyer ce fichier à ton API ou backend
    } else {
      print("Aucune image sélectionnée");
    }
  } */
  ///Upload user profile end

  bool _dataValidation() {
    if (passwordController.text.trim() != confirmPasswordController.text.trim()) {
      //MessageSnackBar.customSnackBar("Warning".tr, "Mot de passe ne correspondent pas".tr, SnackPosition.TOP);
      MessageSnackBar.errorToast(
          title: "Warning".tr,
          message: "Mot de passe ne correspondent pas",
          position: SnackPosition.TOP,
          duration: 2);
      return false;
    }
    return true;
  }

  saveBtn() async {
    /*
    debugPrint('-----------------saveBtn');
    //if(formSignUpKey.currentState!.validate()){}
    if(_dataValidation() && formSignUpStepperKey.currentState!.validate()){
      debugPrint('firstname : ${firstNameController.text.trim()}');
      debugPrint('lastname : ${lastNameController.text.trim()}');
      debugPrint('phone : ${phoneController.text.trim()}');
      debugPrint('city : ${villeController.text.trim()}');
      debugPrint('zipcode : ${codePostalController.text.trim()}');
      debugPrint('state : ${regionController.text.trim()}');
      debugPrint('address : ${addressController.text.trim()}');
      debugPrint('password : ${passwordController.text.trim()}');
      debugPrint('email : ${emailController.text.trim()}');
      debugPrint('token : ${tokenParameter.toString()}');
      try {
        await apiClient.registerUser(
            {
              "firstname": firstNameController.text.trim(),
              "lastname": lastNameController.text.trim(),
              "phone": phoneController.text.trim(),
              "city": villeController.text.trim(),
              "zipcode": codePostalController.text.trim(),
              "state": regionController.text.trim(),
              "address": addressController.text.trim(),
              "password": passwordController.text.trim(),
              "company_name": "",
              "tsp_number": "",
              "tvq_number": "",
              "type_id": "",
              "id_file_url": "",
              "idFile": [],
              "accept_conditions": true,
              "email": emailController.text.trim(),
              "token": tokenParameter.toString()
            })
            .then((value) async {
          await PrefUtils.setTokenVerifAccount(tokenParameter.toString());
          debugPrint('value : ${value}');
          Get.offAndToNamed(Routes.signUpSuccessScreen, arguments: {
            "EmailAccount" : emailController.text.trim(),
            "PasswordAccount": passwordController.text.trim()
          });
          //MessageSnackBar.successSnackBar(title: 'Successfully', message: 'User created successfully.');
          MessageSnackBar.informationToast(
              title: 'Successfully',
              message: "User created successfully.",
              position: SnackPosition.BOTTOM,
              duration: 3);
        })
            .onError((error, stackTrace){
          debugPrint('error register : ${error.toString()}');
          if(error.toString() == '404' || error == 404){
            //MessageSnackBar.errorSnackBar(title: 'Erreur', message: "Impossible de trouver d'utilisateur correspondant au lien de vérification. Veuillez vérifier les informations fournies et réessayer.");
            MessageSnackBar.errorToast(
                title: 'Erreur',
                message: "Impossible de trouver d'utilisateur correspondant au lien de vérification. Veuillez vérifier les informations fournies et réessayer.",
                position: SnackPosition.BOTTOM,
                duration: 3);
          }
          else {
            //MessageSnackBar.errorSnackBar(title: 'Erreur', message: error.toString());
            MessageSnackBar.errorToast(
                title: 'Erreur',
                message: error.toString(),
                position: SnackPosition.BOTTOM,
                duration: 3);
          }
        });
      }
      catch (e) {
        MessageSnackBar.errorToast(
            title: 'Exception',
            message: e.toString(),
            position: SnackPosition.BOTTOM,
            duration: 3);
        //MessageSnackBar.errorSnackBar(title: 'Exception', message: e.toString());
        //isDataProcessing(false);
        //ShowSnackBar.snackBar("Exception", exception.toString(), Colors.red);
      } finally {
        //isDataProcessing.value = false;
      }
    }
    */
  }

}


class TextCounterController extends GetxController {
  final int maxLength;
  final TextEditingController textController = TextEditingController();

  TextCounterController(this.maxLength) {
    textController.addListener(_updateCount);
  }

  var remaining = 0.obs;
  var errorText = "".obs;

  void _updateCount() {
    final currentLength = textController.text.length;
    remaining.value = maxLength - currentLength;

    if (currentLength > maxLength) {
      errorText.value = "Vous ne pouvez pas dépasser $maxLength caractères.";
    } else {
      errorText.value = "";
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}