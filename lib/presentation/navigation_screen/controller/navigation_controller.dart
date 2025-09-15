
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/logger.dart';
import 'package:flutter/foundation.dart';

class NavigationController extends GetxController {
  var email = PrefUtils.getEmail();
  var firstName = PrefUtils.getFirstname() ?? 'Saber';
  var lastName = PrefUtils.getLastName() ?? 'Jdidi';

  RxInt selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  //final apiClient = Get.find<ApiClient>();
  final token = PrefUtils.getToken();

  Rx<int> numberEnchersEncours = 0.obs;
  Rx<int> numberFavoris = 0.obs;

  Rx<bool> isDataProcessing = false.obs;

  //final RxList<AnnonceModel> listContrat = <AnnonceModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchStatistic();
  }

  fetchStatistic() async {
    try {
      isDataProcessing.value = true;
      debugPrint('fetchStatistic');

      //dynamic
    /*  await apiClient.getStatistic(token)
          .then((value){
        debugPrint('value in navigation : $value');
        numberEnchersEncours.value = value['total_bid']; //value['total_won']; //dynamic
        numberFavoris.value = value['total_favorite']; //dynamic
        debugPrint('numberEnchersEncours : $numberEnchersEncours');
        isDataProcessing.value = false;
      })
          .onError((error, stackTrace){
        if(error.toString() == '401' || error == 401){
          debugPrint('unauthorized : ${error.toString()}');
        } else {
          debugPrint('error login : ${error.toString()}');
          MessageSnackBar.errorSnackBar(title: 'Error', message: error.toString());
        }
        isDataProcessing.value = false;
      });
      */

    } catch (error, stackTrace) {
      //ProgressDialogUtils.hideProgressDialog();
      MessageSnackBar.errorSnackBar(title: 'Error', message: error.toString());
      Logger.log(
        error,
        stackTrace: stackTrace,
      );
      isDataProcessing.value = false;
      rethrow;
    } finally {
      isDataProcessing.value = false;
    }
  }

}