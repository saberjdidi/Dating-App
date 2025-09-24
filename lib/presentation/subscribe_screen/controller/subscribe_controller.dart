import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/pref_utils.dart';
import 'package:dating_app_bilhalal/data/models/subscribe_model.dart';
import 'package:dating_app_bilhalal/presentation/password_screen/password_success_screen.dart';
import 'package:dating_app_bilhalal/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscribeController extends GetxController {
  static SubscribeController get instance => Get.find();

  final GlobalKey<FormState> formSubscribeKey = GlobalKey<FormState>();
  //RxInt subscribeValue = 0.obs;
  RxInt selectedIndex = (-1).obs;
  Rx<SubscribeModel?> selectedPlan = Rx<SubscribeModel?>(null);


  Rx<List<SubscribeModel>> plans = Rx(
      [
        SubscribeModel(
            title: "اشتراک ذهبي",
            description: "\$14.99/month",
            details: ""),
        SubscribeModel(
            title: "اشتراک",
            description: "\$14.99/month",
            details: "${"500 رسالة"} \n ${"إعجابات غير محدودة"} \n ${"انتقاد غير محدود"} \n "),
        SubscribeModel(
            title: "اشتراک",
            description: "\$9.99/month",
            details: ""),
        SubscribeModel(
            title: "اشتراک الماس",
            description: "\$9.99/month",
            details: ""),
      ]
  );
 /* final List<SubscribeModel> plans = [
    SubscribeModel(
        title: "اشتراک ذهبي",
        description: "\$14.99/month",
        details: ""),
    SubscribeModel(
        title: "اشتراک",
        description: "\$14.99/month",
        details: "${"500 رسالة"} \n ${"إعجابات غير محدودة"} \n ${"انتقاد غير محدود"} \n "),
    SubscribeModel(
        title: "اشتراک",
        description: "\$9.99/month",
        details: ""),
    SubscribeModel(
        title: "اشتراک الماس",
        description: "\$9.99/month",
        details: ""),
  ]; */

  @override
  void onInit() {
    super.onInit();
    loadSubscriptionPlan();
  }

  Future<void> loadSubscriptionPlan() async {
    final savedPlan = await PrefUtils.getSubscriptionPlan();
    if (savedPlan != null) {
      final plan = SubscribeModel.fromMap(savedPlan);
      selectedPlan.value = plan;
      selectedIndex.value = plans.value.indexWhere((p) => p.title == plan.title);
    }
  }

  void selectPlan(int index) {
    selectedIndex.value = index;
    selectedPlan.value = plans.value[index];
  }

  Future<void> validatePlan() async {
    if (selectedPlan.value != null) {
      //await PrefUtils.setSubscriptionPlan(plans[selectedIndex.value].toMap());
      await PrefUtils.setSubscriptionPlan(selectedPlan.value!.toMap());
      Get.snackbar("Succès", "Plan ${selectedPlan.value!.title} enregistré !");
    }
  }


  confirmChangePlan(BuildContext context, int index){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (builder) =>
            CustomDialog(
              icon: Icons.close,
              onCancel: (){
                Get.back();
              },
              onTap: () async {
                selectPlan(index);
                await validatePlan();
                Get.back();
              },
              //cancelText: "lbl_no".tr,
              successText: "نشيط".tr,
              title: "هل أنت متأكد أنك تريد تغيير خطة اشتراكك؟".tr,
              description: "سيتم تفعيل الخطة الجديدة على الفور.".tr,
              descriptionTextStyle: CustomTextStyles.titleSmallGray400,
              image: ImageConstant.imgWarning,
            )
    );
  }
/* Future<void> confirmChangePlan(int index) async {
    if (plans.value[index].title != selectedPlan.value?.title) {
      Get.defaultDialog(
        title: "Confirmation",
        middleText: "Voulez-vous changer le plan vers ${plans.value[index].title} ?",
        textConfirm: "Oui",
        textCancel: "Non",
        onConfirm: () async {
          selectPlan(index);
          await validatePlan();
          Get.back();
        },
      );
    }
  } */
}

