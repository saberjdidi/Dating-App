import 'package:dating_app_bilhalal/presentation/password_screen/password_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscribeController extends GetxController {
  static SubscribeController get instance => Get.find();

  final GlobalKey<FormState> formSubscribeKey = GlobalKey<FormState>();

  //final apiClient = Get.find<ApiClient>();

  RxInt subscribeValue = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }


}