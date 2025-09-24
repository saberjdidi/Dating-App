import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:flutter/material.dart';

class CallController extends GetxController {
  static CallController get instance => Get.find();

  //color
  RxString selectedColor = ''.obs;
  selectColor(String color) {
    selectedColor.value = color;
    debugPrint('color : $color');
  }
}