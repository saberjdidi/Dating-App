import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class THelperFunctions {
  static Color? getColor(String value) {
    /// Define your product specific colors here and it will match the attribute colors and show specific 🟠🟡🟢🔵🟣🟤

    if (value == 'fair') {
      return TColors.skinColor1;
    } else if (value == 'light') {
      return TColors.skinColor2;
    } else if (value == 'light2') {
      return TColors.skinColor3;
    } else if (value == 'medium') {
      return TColors.skinColor4;
    } else if (value == 'olive') {
      return TColors.skinColor5;
    } else if (value == 'brown') {
      return TColors.skinColor6;
    } else if (value == 'tan') {
      return TColors.skinColor7;
    } else if (value == 'deep') {
      return TColors.skinColor8;
    }
    else if (value == 'filterColorCallVideo1') {
      return TColors.filterColorCallVideo1;
    }
    else if (value == 'filterColorCallVideo2') {
      return TColors.filterColorCallVideo2;
    }
    else if (value == 'filterColorCallVideo3') {
      return TColors.filterColorCallVideo3;
    }
    else if (value == 'filterColorCallVideo4') {
      return TColors.filterColorCallVideo4;
    }
    else if (value == 'filterColorCallVideo5') {
      return TColors.filterColorCallVideo5;
    }
    else if (value == 'green') {
      return Colors.green;
    } else if (value == 'red') {
      return Colors.red;
    } else if (value == 'blue') {
      return Colors.blue;
    } else if (value == 'pink') {
      return Colors.pink;
    } else if (value == 'grey') {
      return Colors.grey;
    } else if (value == 'purple') {
      return Colors.purple;
    } else if (value == 'black') {
      return Colors.black;
    } else if (value == 'white') {
      return Colors.white;
    } else if (value == 'yellow') {
      return Colors.yellow;
    } else if (value == 'orange') {
      return Colors.deepOrange;
    } else if (value == 'brown') {
      return Colors.brown;
    } else if (value == 'teal') {
      return Colors.teal;
    } else if (value == 'indigo') {
      return Colors.indigo;
    } else {
      return null;
    }
  }

  static List<Color> randomColorList = const [
    Color(0xFFF3E179), // jaune clair
    Color(0xFFE1BEE7), // violet clair
    Color(0xFF7AC5EC), // bleu clair
    Color(0xFF7AE77F), // vert clair
    Color(0xF9F3D19A), // orange clair
    Color(0xFFF5BFC7), // rose clair
  ];

  static void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getFormattedDate(DateTime date, {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }

  /// ======== ❤️ MARITAL STATUS (SocialState) ========
  /// Convert Arabic social state to backend enum
  static String getSocialStateEnum(String arabicValue) {
    switch (arabicValue.trim()) {
      case 'أعزب':
        return 'single';
      case 'متزوج':
        return 'married';
      case 'مطلق':
      case 'مُطلّق':
        return 'divorced';
      case 'أرمل':
        return 'widowed';
      default:
        return 'other';
    }
  }

  /// Convert backend enum to Arabic
  static String getSocialStateArabic(String englishValue) {
    switch (englishValue.trim()) {
      case 'single':
        return 'أعزب';
      case 'married':
        return 'متزوج';
      case 'divorced':
        return 'مطلق';
      case 'widowed':
        return 'أرمل';
      default:
        return 'آخر';
    }
  }

  /// ======== 💍 LOOKING FOR (Marriage Type) ========
  /// Convert Arabic marriage type to backend enum
  static String getMarriageTypeEnum(String arabicValue) {
    switch (arabicValue.trim()) {
      case 'الصداقة':
        return 'friend';
      case 'مواعدة':
        return 'date';
      case 'معيشة':
        return 'living_partner';
      case 'زواج':
      case 'زواج معلن دائم':
      case 'زواج سري دائم':
        return 'marriage';
      default:
        return 'other';
    }
  }

  /// Convert backend enum to Arabic (for display)
  static String getMarriageTypeArabic(String englishValue) {
    switch (englishValue.trim()) {
      case 'friend':
        return 'الصداقة';
      case 'date':
        return 'مواعدة';
      case 'living_partner':
        return 'معيشة';
      case 'marriage':
        return 'زواج';
      default:
        return 'آخر';
    }
  }

  /// ======== 🏳️ COUNTRY ========
  /// Convert Arabic social state to backend enum
  static String getCountryEnum(String arabicValue) {
    switch (arabicValue.trim()) {
      case 'الكل':
        return 'All';
      case 'تونس':
        return 'Tunisia';
      case 'البحرین':
        return 'Bahrain';
      case 'الامارات':
        return 'UAE';
      case 'قطر':
        return 'Qatar';
      case 'الکویت':
        return 'Kuwait';
      case 'السعودیة':
        return 'Saudi Arabia';
      case 'العراق':
        return 'Iraq';
      case 'عمان':
        return 'Oman';
      case 'المغرب':
        return 'Morocco';
      case 'لبنان':
        return 'Lebanon';
      default:
        return 'Other';
    }
  }

  /// Convert backend enum to Arabic (for display)
  static String getCountryArabic(String englishValue) {
    switch (englishValue.trim()) {
      case 'All':
      case 'all':
        return 'الكل';
      case 'Tunisia':
      case 'Tunis':
        return 'تونس';
      case 'Bahrain':
        return 'البحرین';
      case 'UAE':
      case 'uae':
        return 'الامارات';
      case 'Qatar':
        return 'قطر';
      case 'Kuwait':
        return 'الکویت';
      case 'Saudi Arabia':
        return 'السعودیة';
      case 'Iraq':
        return 'العراق';
      case 'Oman':
        return 'عمان';
      case 'Morocco':
        return 'المغرب';
      case 'Lebanon':
        return 'لبنان';
      default:
        return 'آخر';
    }
  }

  /// ======== 🎯 INTERESTS ========

  /// Convert Arabic interest to English (for sending to backend)
  static String getInterestEnum(String arabicValue) {
    switch (arabicValue.trim()) {
      case 'التسوق':
        return 'Shopping';
      case 'فوتوغرافيا':
        return 'Photography';
      case 'اليوغا':
        return 'Yoga';
      case 'كاريوكي':
        return 'Karaoke';
      case 'التنس':
        return 'Tennis';
      case 'طبخ':
        return 'Cooking';
      case 'سباحة':
        return 'Swimming';
      case 'ركض':
        return 'Running';
      case 'السفر':
        return 'Travel';
      case 'فن':
        return 'Art';
      case 'موسيقى':
        return 'Music';
      case 'الرفاهية':
        return 'Luxury';
      case 'ألعاب الفيديو':
        return 'Video Games';
      case 'قراءة':
        return 'Reading';
      case 'كرة القدم':
        return 'Football';
      case 'الشطرنج':
        return 'Chess';
      case 'الاسترخاء':
        return 'Chilling';
      default:
        return 'Other';
    }
  }

  /// Convert English interest to Arabic (for displaying)
  static String getInterestArabic(String englishValue) {
    switch (englishValue.trim()) {
      case 'Shopping':
      case 'shopping':
        return 'التسوق';
      case 'Photography':
      case 'photography':
        return 'فوتوغرافيا';
      case 'Yoga':
      case 'yoga':
        return 'اليوغا';
      case 'Karaoke':
      case 'karaoke':
        return 'كاريوكي';
      case 'Tennis':
      case 'tennis':
        return 'التنس';
      case 'Cooking':
      case 'cooking':
        return 'طبخ';
      case 'Swimming':
      case 'swimming':
        return 'سباحة';
      case 'Running':
      case 'running':
        return 'ركض';
      case 'Travel':
      case 'travel':
        return 'السفر';
      case 'Art':
      case 'art':
        return 'فن';
      case 'Music':
      case 'music':
        return 'موسيقى';
      case 'Video Games':
      case 'gaming':
        return 'ألعاب الفيديو';
      case 'Reading':
      case 'reading':
        return 'قراءة';
      case 'Football':
      case 'football':
        return 'كرة القدم';
      case 'Chess':
      case 'chess':
        return 'الشطرنج';
      case 'Chilling':
      case 'chilling':
        return 'الاسترخاء';
      case 'Luxury':
      case 'luxury':
        return 'الرفاهية';
      default:
        return 'آخر';
    }
  }
}
