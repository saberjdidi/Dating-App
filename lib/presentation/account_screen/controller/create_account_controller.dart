import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:flutter/material.dart';

class CreateAccountController extends GetxController {
  RxInt currentIndexStepper = 0.obs;

  final GlobalKey<FormState> formSignUpStepperKey = GlobalKey<FormState>();

  ///ImStepper
  // REQUIRED: USED TO CONTROL THE STEPPER.
  RxInt activeStep = 0.obs; // Initial step set to 0.
  // OPTIONAL: can be set directly.
  RxInt dotCount = 3.obs;

  //final apiClient = Get.find<ApiClient>();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController lookingForController = TextEditingController();
  TextEditingController jobController = TextEditingController();
  TextEditingController paysController = TextEditingController();
  RxInt sexValue = 0.obs;
  RxInt currentSliderValue = 20.obs;
  RxInt currentWeightValue = 50.obs;
  RxInt currentHeightValue = 170.obs;

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Rx<bool> isShowPassword = true.obs;
  Rx<bool> isProcessing = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

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