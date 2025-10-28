import 'dart:io';
import 'dart:math';
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/network_manager.dart';
import 'package:dating_app_bilhalal/core/utils/permissions_helper.dart';
import 'package:dating_app_bilhalal/data/models/country_model.dart';
import 'package:dating_app_bilhalal/data/models/selection_popup_model.dart';
import 'package:dating_app_bilhalal/data/repositories/media_repository.dart';
import 'package:dating_app_bilhalal/data/repositories/profile_repository.dart';
import 'package:dating_app_bilhalal/data/repositories/user_repository.dart';
import 'package:dating_app_bilhalal/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccountController extends GetxController {
  static CreateAccountController get instance => Get.find();
  RxInt currentIndexStepper = 0.obs;
  var isRTL = true.obs;
  var isArabe = PrefUtils.getLangue() == 'ar';

  final GlobalKey<FormState> formCreateAccountKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formOverviewAccountKey = GlobalKey<FormState>();
  final ProfileRepository profileRepository = ProfileRepository();
  final MediaRepository mediaRepository = MediaRepository();
  final userRepository = UserRepository();
  RxBool isDataProcessing = false.obs;

  ///ImStepper
  // REQUIRED: USED TO CONTROL THE STEPPER.
  RxInt activeStep = 0.obs; // Initial step set to 0.
  // OPTIONAL: can be set directly.
  RxInt dotCount = 4.obs;

  //final apiClient = Get.find<ApiClient>();

  //final TextCounterController nameCounterController = Get.put(TextCounterController(100));

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

  RxString sexValue = 'male'.obs;
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
    getCountries();
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

  ///Countries
  final RxList<CountryModel> countriesList = <CountryModel>[].obs;
  Future<void> getCountries() async {
    try {
      isDataProcessing.value = true;

      final result = await userRepository.getCountries();

      if (result.success && result.data != null) {
        final apiCountries = result.data!;

        countriesList
          ..clear()
          ..addAll(apiCountries);
      } else {
        MessageSnackBar.errorSnackBar(
          title: "خطأ",
          message: result.message ?? "فشل في جلب الدول",
        );
      }
    } catch (e) {
      MessageSnackBar.errorSnackBar(title: "خطأ", message: e.toString());
    } finally {
      isDataProcessing.value = false;
    }
  }


  Future<void> createAccount() async {
    try {
      final isValid = formOverviewAccountKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      formOverviewAccountKey.currentState!.save();

      // ✅ Vérifier si l’utilisateur a sélectionné des intérêts
      if (selectedInterests.isEmpty) {
        MessageSnackBar.customToast(message: 'الرجاء اختيار على الأقل اهتمام واحد');
        return;
      }

      // ✅ Vérifier qu'au moins une image a été ajoutée
      if (selectedMedia.isEmpty) {
        MessageSnackBar.customToast(message: 'الرجاء تحميل صورة واحدة على الأقل');
        return;
      }

      // ✅ Vérifier l'image de profile
      if (selectedImage.value == null) {
        MessageSnackBar.customToast(message: 'الرجاء تحميل صورة الملف');
        return;
      }

      isDataProcessing.value = true;
      //FullScreenLoader.openLoadingDialog('Loading...', ImageConstant.lottieLoading);

      // ✅ Vérifier la connexion internet
      final isConnected = await NetworkManager.instance.isConnected();
      if(!isConnected) {
        isDataProcessing.value = false;
        //Remove Loader
        //FullScreenLoader.stopLoading();
        MessageSnackBar.customToast(message: 'No Internet Connection');
        return;
      }

      // ✅ Convertir les intérêts en anglais avant l’envoi
      final hobbiesInEnglish = selectedInterests
          .map((arabic) => THelperFunctions.getInterestEnum(arabic))
          .toList();

      // ✅ Créer le compte
      final result = await profileRepository.createAccount(
        username: fullNameController.text.trim(),
        bio: bioController.text.trim(),
        gender: sexValue.value,
        age: int.parse(currentAgeValue.value.round().toString()),
        height: int.parse(currentHeightValue.value.round().toString()),
        weight: int.parse(currentWeightValue.value.round().toString()),
        socialState: THelperFunctions.getSocialStateEnum(maritalStatusController.text), //maritalStatusController.text.trim(),
        marriageType: THelperFunctions.getMarriageTypeEnum(lookingForController.text), //lookingForController.text.trim(),
        jobTitle: jobController.text.trim(),
        salaryRangeMin: currentRangeValues.value.start.round().toString(),
        salaryRangeMax: currentRangeValues.value.end.round().toString(),
        country: selectedPays.value != null ? selectedPays.value!.id! : '',//paysController.text.trim(), //THelperFunctions.getCountryEnum(paysController.text),
        skinColor: selectedColor.value, // ✅ couleur sélectionnée //"Tan"//selectedColor.value
        hobbies: hobbiesInEnglish, // ✅ envoyé en anglais
      );

      final userProfileResult = await mediaRepository.uploadProfileImage(selectedImage.value);
      if (userProfileResult.success) {
        MessageSnackBar.successSnackBar(title: 'تم', message: 'تم تحميل صورة الملف بنجاح');
        //isDataProcessing.value = false;
        final profileUrl = userProfileResult.data?['user']?['main_profile_url'];
        debugPrint("profileUrl : $profileUrl");
        if (profileUrl != null) {
          await PrefUtils.setImageProfile(profileUrl);
        }
      } else {
        MessageSnackBar.errorSnackBar(title: 'خطأ', message: userProfileResult.message ?? '');
        isDataProcessing.value = false;
      }



      if (result.success) {
        //Get.offAllNamed(Routes.successAccountScreen);
        MessageSnackBar.successSnackBar(title: 'تم', message: result.message ?? '');
        //isDataProcessing.value = false;
        // ✅ Upload toutes les images sélectionnées une par une
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

          // ✅ Si c’est le dernier fichier ET upload réussi → afficher message de succès
          if (uploadResult.success && i == selectedMedia.length - 1) {
            Get.offAllNamed(Routes.successAccountScreen);
            isDataProcessing.value = false;
            MessageSnackBar.successSnackBar(title: 'تم', message: uploadResult.message ?? 'تم تحميل جميع الصور بنجاح',);
          }
        }
      } else {
        MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? 'An error occured');
        isDataProcessing.value = false;
      }

      // ✅ Upload la première image
      //final firstFile = selectedMedia.first;
      //final uploadResult = await mediaRepository.uploadOneMedia(firstFile);
      // ✅ Upload plusieurs images
      /* final uploadResult = await mediaRepository.uploadMultiMedia(selectedMedia);
        if (uploadResult.success) {
          //Get.offAllNamed(Routes.successAccountScreen);
          MessageSnackBar.successSnackBar(title: 'تم', message: uploadResult.message ?? 'تم تحميل الصور بنجاح');
          isDataProcessing.value = false;
        } else {
          MessageSnackBar.errorSnackBar(title: 'خطأ', message: uploadResult.message ?? '');
          isDataProcessing.value = false;
        } */

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

  saveBtn() async {
    if(formOverviewAccountKey.currentState!.validate()){
      try {
        debugPrint('We are processing your information');
        //Start Loading
        //FullScreenLoader.openLoadingDialog('We are processing your information...', ImageConstant.lottieTrophy);

        //Check internet connection
        final isConnected = await NetworkManager.instance.isConnected();
        if(!isConnected) {
          //Remove Loader
          //FullScreenLoader.stopLoading();
          return;
        }

        /* final isValid = formSignUpKey.currentState!.validate();
      if (!isValid) {
        return;
      }
      formSignUpKey.currentState!.save(); */
        if(!formOverviewAccountKey.currentState!.validate()) {
          //Remove Loader
          //FullScreenLoader.stopLoading();
          return;
        }

        //Register user in the Firebase authentication & save user data in the Firebase
        // await AuthenticationRepository.instance.registerWithEmailAndPassword(emailController.text.trim(), passwordController.text.trim());

        //Remove Loader
        //FullScreenLoader.stopLoading();

        Get.offAllNamed(Routes.successAccountScreen);

        //Show success message
        MessageSnackBar.successSnackBar(title: 'Successfully', message: 'Your account has been created!');

      }
      catch (exception) {
        debugPrint('Exception : ${exception.toString()}');
        //FullScreenLoader.stopLoading();

        //Show some generic error to the user
        MessageSnackBar.errorSnackBar(title: 'Oh Snap!', message: exception.toString());
      } finally {
        //isDataProcessing.value = false;
      }
    }
  }

}