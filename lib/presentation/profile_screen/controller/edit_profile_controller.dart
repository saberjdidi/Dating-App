import 'dart:io';
import 'dart:math';
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/helpers/dropdown_functions.dart';
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

  RxDouble currentAgeValue = 25.toDouble().obs;
  RxDouble currentWeightValue = 50.toDouble().obs;
  RxDouble currentHeightValue = 170.toDouble().obs;
  var currentRangeValues = const RangeValues(177, 300).obs;
  //color
  RxString selectedColor = ''.obs;
  selectColor(String color) {
    selectedColor.value = color;
    debugPrint('Couleur sélectionnée : $color');
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

  RxInt jobRemaining = 20.obs;
  RxString jobError = "".obs;
  void onJobChanged(String value) {
    jobRemaining.value = 20 - value.length;
    if (value.length > 20) {
      jobError.value = "الاسم الكامل لا يمكن أن يتجاوز 50 حرف.";
    } else {
      jobError.value = "";
    }
  }
  ///Max Length TextFormField End

  @override
  void onInit() {
    super.onInit();
    // Charger données de l’utilisateur
    getInformationUser();
  }

  getInformationUser(){
    try {
      fullNameController.text = userInfo.username! ?? '';
      bioController.text = userInfo.profile!.description ?? '';
      jobController.text = userInfo.profile!.jobTitle ?? '';
      currentAgeValue.value = userInfo.age != null ? (userInfo.age! < 18 ? 18 : userInfo.age!.toDouble()) : 20;
      currentHeightValue.value = userInfo.height != null ? userInfo.height!.toDouble() : 0;
      currentWeightValue.value = userInfo.weight != null ? userInfo.weight!.toDouble() : 0;
      selectedColor.value = userInfo.profile!.skinToneHex! ?? '';

      final profile = userInfo.profile;
      debugPrint("user Info : ${userInfo.profile?.socialState}");
     // if (profile != null) {}
        // --- Social State ---
        final socialArabic = THelperFunctions.getSocialStateArabic(userInfo.profile?.socialState ?? '');
        maritalStatusController.text = socialArabic;
        debugPrint("socialArabic : ${socialArabic}");

        final socialItem = ListMaritalStatus.value.firstWhereOrNull((item) => item.title == userInfo.profile?.socialState);
        //final socialItem = ListMaritalStatus.value.firstWhereOrNull((item) => item.title == socialArabic);
        selectedMaritalStatus.value = socialItem;

        // --- Marriage Type ---
        final marriageArabic = THelperFunctions.getMarriageTypeArabic(userInfo.profile?.marriageType ?? '');
        lookingForController.text = marriageArabic;


        final marriageItem = ListLookingFor.value.firstWhereOrNull((item) => item.title == userInfo.profile?.marriageType);
        //final marriageItem = ListLookingFor.value.firstWhereOrNull((item) => item.title == marriageArabic);
        selectedLookingFor.value = marriageItem;
        debugPrint("marriageItem : ${marriageItem!.title}");
        // --- Country ---
        final countryArabic = THelperFunctions.getCountryArabic(userInfo.profile?.country ?? '');
        paysController.text = countryArabic;

        final countryItem = PaysList.value.firstWhereOrNull(
                (item) => item.name == countryArabic);
        selectedPays.value = countryItem;
        debugPrint("countryItem : ${countryItem!.name}");


      // ✅ Charger les salaires min/max
      final minSalary = double.tryParse(userInfo.profile?.salaryRangeMin ?? '') ?? 177;
      final maxSalary = double.tryParse(userInfo.profile?.salaryRangeMax ?? '') ?? 300;

      // ✅ Si min > max, on inverse pour éviter erreur
      if (minSalary > maxSalary) {
        currentRangeValues.value = RangeValues(maxSalary, minSalary);
      } else {
        currentRangeValues.value = RangeValues(minSalary, maxSalary);
      }

      debugPrint("✅ Loaded salary range: $minSalary - $maxSalary");
    } catch (e) {
      debugPrint("⚠️ Error parsing salary range: $e");
      currentRangeValues.value = const RangeValues(177, 300);
    }
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
          socialState: THelperFunctions.getSocialStateEnum(maritalStatusController.text), //maritalStatusController.text.trim(),
          marriageType: THelperFunctions.getMarriageTypeEnum(lookingForController.text), //lookingForController.text.trim(),
          jobTitle: jobController.text.trim(),
          salaryRangeMin: currentRangeValues.value.start.round().toString(),
          salaryRangeMax: currentRangeValues.value.end.round().toString(),
          country: userInfo.profile!.country!,//THelperFunctions.getCountryEnum(paysController.text), //paysController.text.trim(),
          skinColor: selectedColor.value, // ✅ couleur sélectionnée //"Tan"//selectedColor.value
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