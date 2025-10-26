import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/subscription_plan_model.dart';
import 'package:dating_app_bilhalal/data/repositories/subscription_repository.dart';
import 'package:dating_app_bilhalal/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscribeController extends GetxController {
  static SubscribeController get instance => Get.find();

  final SubscriptionRepository _subscriptionRepository =
      SubscriptionRepository();

  final GlobalKey<FormState> formSubscribeKey = GlobalKey<FormState>();

  //RxInt subscribeValue = 0.obs;
  RxInt selectedIndex = (-1).obs;
  Rx<SubscriptionPlanModel?> selectedPlan = Rx<SubscriptionPlanModel?>(null);

  // API-related observables
  var isLoading = false.obs;

  Rx<List<SubscriptionPlanModel>> plans = Rx<List<SubscriptionPlanModel>>([]);

  @override
  void onInit() {
    super.onInit();
    loadSubscriptionPlans();
  }

  /// Fetch subscription plans from API
  Future<void> loadSubscriptionPlans() async {
    try {
      isLoading.value = true;

      final result = await _subscriptionRepository.getSubscriptionPlans();

      if (result.success && result.data != null) {
        // Convert API models to UI models
        selectedPlan.value = result.data?.activePlan;
        plans.value = result.data?.inactivePlans ?? [];
      } else {
        MessageSnackBar.errorSnackBar(title: "خطأ", message: result.message??'');

      }
    } catch (e) {
      MessageSnackBar.errorSnackBar(title: "خطأ", message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  /// Check if user has an active subscription
  bool get hasActiveSubscription => selectedPlan.value != null;

  void selectPlan(int index) {
    selectedIndex.value = index;
    selectedPlan.value = plans.value[index];
  }


  confirmChangePlan(BuildContext context, int index) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (builder) => CustomDialog(
              icon: Icons.close,
              onCancel: () {
                Get.back();
              },
              onTap: () async {
                selectPlan(index);
                Get.back();
              },
              cancelText: "يلغي".tr,
              successText: "نشيط".tr,
              title: "هل أنت متأكد أنك تريد تغيير خطة اشتراكك؟".tr,
              description: "سيتم تفعيل الخطة الجديدة على الفور.".tr,
              descriptionTextStyle: CustomTextStyles.titleSmallGray400,
              image: ImageConstant.imgWarning,
            ));
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
