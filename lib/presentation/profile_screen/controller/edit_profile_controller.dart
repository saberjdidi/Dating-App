import 'dart:io';
import 'dart:math';
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/network_manager.dart';
import 'package:dating_app_bilhalal/core/utils/permissions_helper.dart';
import 'package:dating_app_bilhalal/data/datasources/dropdown_local_data_source.dart';
import 'package:dating_app_bilhalal/data/models/country_model.dart';
import 'package:dating_app_bilhalal/data/models/selection_popup_model.dart';
import 'package:dating_app_bilhalal/data/models/user_model.dart';
import 'package:dating_app_bilhalal/data/repositories/profile_repository.dart';
import 'package:dating_app_bilhalal/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileController extends GetxController {
  RxInt currentIndexStepper = 0.obs;
  var isRTL = true.obs;

  final GlobalKey<FormState> formEditProfileKey = GlobalKey<FormState>();

  UserModel userInfo  = Get.arguments['UserInfo'] ?? UserModel.empty();
  final profileRepository = ProfileRepository();
  RxBool isDataProcessing = false.obs;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController lookingForController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController paysController = TextEditingController();
  // Dropdowns
  final selectedPays = Rxn<CountryModel>();
  final selectedMaritalStatus = Rxn<SelectionPopupModel>();
  final selectedLookingFor = Rxn<SelectionPopupModel>();

  //FocusNodes
  FocusNode fullNameFocus = FocusNode();
  FocusNode bioFocus = FocusNode();
  FocusNode jobFocus = FocusNode();
  FocusNode maritalStatusFocus = FocusNode();
  FocusNode lookingForFocus = FocusNode();
  FocusNode paysFocus = FocusNode();

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
  // Map pour mémoriser la couleur random de chaque intérêt sélectionné
  final selectedInterestColors = <String, Color>{}.obs;

  void toggleInterestWithColor(String interest, BuildContext context) {
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
      selectedInterestColors.remove(interest); // 🔹 supprimer la couleur associée
    } else {
      if (selectedInterests.length >= 5) {
        showMaxInterestDialog(context);
        return;
      }
      selectedInterests.add(interest);
      // 🔹 assigner une couleur aléatoire si non déjà attribuée
      selectedInterestColors[interest] =
      THelperFunctions.randomColorList[Random().nextInt(THelperFunctions.randomColorList.length)];
    }

    debugPrint('selectedInterests : $selectedInterests');
  }


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
    fullNameController.text = userInfo.username! ?? '';
    bioController.text = userInfo.profile!.description ?? '';
    jobController.text = userInfo.profile!.jobTitle ?? '';
    currentAgeValue.value = userInfo.age != null ? userInfo.age!.toDouble() : 0;
    currentHeightValue.value = userInfo.height != null ? userInfo.height!.toDouble() : 0;
    currentWeightValue.value = userInfo.weight != null ? userInfo.weight!.toDouble() : 0;
    //currentRangeValues.value = RangeValues(double.parse(userInfo.profile!.salaryRangeMin.toString()), double.parse(userInfo.profile!.salaryRangeMax.toString()));
    sexValue.value = userInfo.gender != null ? userInfo.gender! : -1;
    //selectedMaritalStatus.value = ListMaritalStatus.value.first;
    //selectedMaritalStatus.value = userInfo.profile!.socialState != null ? SelectionPopupModel(title: userInfo.profile!.socialState!, id: 1) : SelectionPopupModel(title: "");
  }

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    bioController.dispose();
    maritalStatusController.dispose();
    jobController.dispose();
    lookingForController.dispose();
    paysController.dispose();

    fullNameFocus.dispose();
    bioFocus.dispose();
    jobFocus.dispose();
    maritalStatusFocus.dispose();
    lookingForFocus.dispose();
    paysFocus.dispose();
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



  Future<void> saveBtn() async {
    try {
      final isValid = formEditProfileKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      formEditProfileKey.currentState!.save();

      isDataProcessing.value = true;
      //FullScreenLoader.openLoadingDialog('Loading...', ImageConstant.lottieLoading);

      //Check internet connection
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        isDataProcessing.value = false;
        //Remove Loader
        //FullScreenLoader.stopLoading();
        MessageSnackBar.customToast(message: 'No Internet Connection');
        return;
      }

      final result = await profileRepository.updateProfile(
          username: fullNameController.text.trim(),
          height: int.parse(currentHeightValue.value.round().toString()),
          weight: int.parse(currentWeightValue.value.round().toString()),
          bio: bioController.text.trim(),
          socialState: maritalStatusController.text.trim(),
          marriageType: lookingForController.text.trim(),
          jobTitle: jobController.text.trim(),
          salaryRangeMin: currentRangeValues.value.start.round().toString(),
          salaryRangeMax: currentRangeValues.value.end.round().toString(),
          country: paysController.text.trim(),
          skinColor: selectedColor.value
        );

     /* final result2 = await profileRepository.updateProfile({
        "username": fullNameController.text.trim(),
        "height": int.parse(currentHeightValue.value.round().toString()),
        "weight": int.parse(currentWeightValue.value.round().toString()),
        "description": bioController.text.trim(),
        "social_state": maritalStatusController.text.trim(),
        "marriage_type": lookingForController.text.trim(),
        "job_title": jobController.text.trim(),
        "salary_range_min": currentRangeValues.value.start.round().toString(),
        "salary_range_max": currentRangeValues.value.end.round().toString(),
        "country": paysController.text.trim(),
        "skin_tone_hex": selectedColor
      }); */
      /*
          {
              "username": "Saber Jdidi",
              "height": 180,
              "weight": 75,
              "description": "Software engineer",
              "social_state": "single",
              "marriage_type": "marriage",
              "job_title": "Backend Developer",
              "salary_range_min": "3000",
              "salary_range_max": "6000",
              "country": "Egypt",
              "skin_tone_hex": "olive"
            }
           */

      //FullScreenLoader.stopLoading();

      if (result.success) {
        Get.back();
        MessageSnackBar.successSnackBar(title: 'تم', message: result.message ?? '');
        isDataProcessing.value = false;
      } else {

        MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? 'An error occured');
        isDataProcessing.value = false;
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

}