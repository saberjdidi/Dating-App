import 'package:get/get.dart';

class Validator {
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName ${"إجباري"}';
      //return '$fieldName ${"lbl_is_required".tr}';
    }
    return null;
  }

 /* static String? validateEmptySelectionPopupModel(String? fieldName, SelectionPopupModel? value) {
    if (value == null) {
      return '$fieldName ${"lbl_is_required".tr}.';
    }
    return null;
  } */

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return '${'البريد الإلكتروني'} إجباري';
      //return '${'lbl_email'.tr} ${"lbl_is_required".tr}';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return "البريد إلكتروني غير صالح";
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور إجباري';
      //return 'Password ${"lbl_is_required".tr}';
    }

    // Check for minimum password length
    if (value.length < 8) {
      return "يجب أن تتكون كلمة المرور من 8 أحرف على الأقل.";
    }

    // Check for uppercase letters
   /* if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Le mot de passe doit contenir au moins une lettre majuscule.";
    } */

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return "يجب أن تحتوي كلمة المرور على رقم واحد على الأقل.";
    }

    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "يجب أن تحتوي كلمة المرور على حرف خاص واحد على الأقل.";
    }

    ///English
    /*
    if (value.length < 8) {
      return "Le mot de passe doit comporter au moins 8 caractères.";
    }

    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Le mot de passe doit contenir au moins une lettre majuscule.";
    }

    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return "Le mot de passe doit contenir au moins un chiffre.";
    }

    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "Le mot de passe doit contenir au moins un caractère spécial.";
    }
     */

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return '${'lbl_phone_number'.tr} ${"lbl_is_required"}.';
    }

    // Regular expression for phone number validation (assuming a 10-digit US phone number format)
    final phoneRegExp = RegExp(r'^\d{8}$');

    if (!phoneRegExp.hasMatch(value)) {
      return "lbl_invalid_phone_number".tr;
    }

    return null;
  }

// Add more custom validators as needed for your specific requirements.
}