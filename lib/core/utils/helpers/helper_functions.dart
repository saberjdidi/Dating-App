import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class THelperFunctions {
  static Color? getColor(String value) {
    /// Define your product specific colors here and it will match the attribute colors and show specific 🟠🟡🟢🔵🟣🟤

    if (value == 'skinColor1') {
      return TColors.skinColor1;
    } else if (value == 'skinColor2') {
      return TColors.skinColor2;
    } else if (value == 'skinColor3') {
      return TColors.skinColor3;
    } else if (value == 'skinColor4') {
      return TColors.skinColor4;
    } else if (value == 'skinColor5') {
      return TColors.skinColor5;
    } else if (value == 'skinColor6') {
      return TColors.skinColor6;
    } else if (value == 'skinColor7') {
      return TColors.skinColor7;
    } else if (value == 'skinColor8') {
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
}
