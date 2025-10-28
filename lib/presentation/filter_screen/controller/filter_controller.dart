import 'dart:async';
import 'dart:math';
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/network_manager.dart';
import 'package:dating_app_bilhalal/core/utils/popups/full_screen_loader.dart';
import 'package:dating_app_bilhalal/core/utils/popups/search_dating.dart';
import 'package:dating_app_bilhalal/data/datasources/dropdown_local_data_source.dart';
import 'package:dating_app_bilhalal/data/models/user_model.dart';
import 'package:dating_app_bilhalal/data/models/country_model.dart';
import 'package:dating_app_bilhalal/data/models/interest_model.dart';
import 'package:dating_app_bilhalal/data/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class FilterController extends GetxController with WidgetsBindingObserver {
  static FilterController get instance => Get.find();
  var isArabe = PrefUtils.getLangue() == 'ar';

  var selectedCountries = <String>[].obs;
  //Card Swiper
  final CardSwiperController swiperController = CardSwiperController();
  final RxInt currentIndex = 0.obs;
  int get cardsCount => usersList.length; // Getter pour la taille (performant)

  final userRepository = UserRepository();
  RxList<UserModel> usersList = <UserModel>[].obs;
  RxBool isDataProcessing = false.obs;

  ///Pagination
  RxInt currentPage = 1.obs;
  final int pageSize = 30;
  RxBool hasMore = true.obs;

  ///Search
  TextEditingController maritalStatusController = TextEditingController();
  TextEditingController lookingForController = TextEditingController();
  //TextEditingController paysController = TextEditingController();
  //final Rx<SelectionPopupModel?> selectedPays = Rx<SelectionPopupModel?>(null);
  final Rx<CountryModel?> selectedPays = Rxn<CountryModel?>(null);

  //RxInt sexValue = 0.obs;
  //RxDouble currentAgeValue = 20.toDouble().obs; //choice one age
  var currentRangeAgeValues = const RangeValues(20, 40).obs; // choice range of ages
  //RxDouble currentWeightValue = 50.toDouble().obs;
  var currentRangeWeightValues = const RangeValues(40, 100).obs;
  //RxDouble currentHeightValue = 170.toDouble().obs;
  var currentRangeHeightValues = const RangeValues(100, 200).obs;
  //color
  RxString selectedColor = ''.obs;
  selectColor(String color) {
    selectedColor.value = color;
    debugPrint('color : $color');
  }

  ///Interests Start
  var selectedInterests = <InterestModel>[].obs;

  void toggleInterest(InterestModel interest, BuildContext context) {
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
    } else {
     /* if (selectedInterests.length >= 5) {
        showMaxInterestDialog(context);
        return;
      } */
      selectedInterests.add(interest);
    }
    debugPrint('Interests: ${selectedInterests.map((e) => e.name).toList()}');
  }
  ///Interests end

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    getUsers(socialState: "single", reset: true);
    // Charger les pays, puis définir le pays par défaut
    getCountries().then((_) {
      if (countriesList.isNotEmpty) {
        selectedPays.value = countriesList.first;
      }
    });

    //loadUsers();
    // Démarre le swipe automatique après un petit délai
    //Future.delayed(const Duration(seconds: 2), startAutoSwipe);

    /// ✅ Définir les valeurs par défaut
    //selectedPays.value = countriesList.value.first; //static
    maritalStatusController.text = ListMaritalStatusFilter.first; // "أعزب"
    lookingForController.text = ListMarriageTypeFilter.first; // "زواج معلن دائم"
    //paysController.text = PaysListFilter.value.first.name; // "السعودیة"
  }

  @override
  void onReady() {
    super.onReady();
    SearchDating.openDialogFilterUser(instance);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }


  @override
  void refresh() {

  }

  /// 🔁 Appelé quand l’écran redevient visible
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      debugPrint("🔄 MainScreen resumed → refresh users");
      getUsers(socialState: "single", reset: true);
    }
  }

  /// Méthode pour récupérer les utilisateurs
  Future<void> getUsers({int? minAge, int? maxAge, int? minHeight, int? maxHeight, int? minWeight, int? maxWeight,
    String? socialState, String? marriageType, String? country, bool reset = false}) async {
    try {
      if(reset){
        currentPage.value = 1;
        hasMore.value = true;
        usersList.clear();
      }

      if(!hasMore.value) return;

      isDataProcessing.value = true;

      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        isDataProcessing.value = false;
        MessageSnackBar.customToast(message: 'Pas de connexion Internet');
        return;
      }

      final body = {
        "page": currentPage.value,
        "pageSize": pageSize,
        "country": (country?.isEmpty ?? true) ? '' : country,
        "marriage_type": marriageType,
        "social_state": socialState,
        "minAge": minAge,
        "maxAge": maxAge,
        "minHeight": minHeight,
        "maxHeight": maxHeight,
        "minWeight": minWeight,
        "maxWeight": maxWeight,
        "salary_min": "",
        "salary_max": "",
        "job": "",
        "skin_tune": "",
        "sort": "relevance"
      };
      final result = await userRepository.searchUsers(body);


      if (result.success) {
        //usersList.assignAll(result.data ?? []);
        isDataProcessing.value = false;
        final newUsers = result.data ?? [];
        if(newUsers.isEmpty){
          hasMore.value = false;
        } else {
          usersList.addAll(newUsers);
          currentPage.value++; //incrémente la page
        }
        debugPrint('lenght users:  ${usersList.length}');
      } else {
        isDataProcessing.value = false;
        MessageSnackBar.errorSnackBar(title: 'خطأ', message: result.message ?? '');
      }
    } catch (e) {
      isDataProcessing.value = false;
      MessageSnackBar.errorSnackBar(title: 'خطأ', message: e.toString());
    } finally {
      isDataProcessing.value = false;
    }
  }

  final RxList<CountryModel> countriesList = <CountryModel>[].obs;
  Future<void> getCountries() async {
    try {
      isDataProcessing.value = true;

      final result = await userRepository.getCountries();

      if (result.success && result.data != null) {
        final apiCountries = result.data!;
        final allCountry = CountryModel(name: isArabe ? "الکل" : "All");

        countriesList
          ..clear()
          ..add(allCountry)
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


  toggleCountry(String countryName) {
    if (selectedCountries.contains(countryName)) {
      selectedCountries.remove(countryName);
    } else {
      selectedCountries.add(countryName);
    }
  }

  ///Filter Function
  applyFilters() async {
//Start Loading
    FullScreenLoader.openLoadingSearchDialog("نتائج البحث", "مطابقة الأشخاص مع متطلباتك",ImageConstant.imgLove, ImageConstant.imgLoves);
    //FullScreenLoader.openLoadingDialog('مطابقة الأشخاص مع متطلباتك..', ImageConstant.lottieTrophy);

    final selectedIdCountry = (selectedPays.value?.id != null && selectedPays.value!.id!.isNotEmpty) ? selectedPays.value!.id : "";

    ///Using to send country name in english
    /*  String? countryToSend;
     if (selectedCountry != null) {
      if (isArabe) {
        // Si arabe, on utilise englishName s’il existe, sinon name
        countryToSend = THelperFunctions.getCountryEnum(selectedCountry.name!) ?? selectedCountry.name;
      } else {
        // Si anglais, on garde le nom tel quel
        countryToSend = selectedCountry.name;
      }
    } */

   await getUsers(
       minAge: currentRangeAgeValues.value.start.round(), maxAge: currentRangeAgeValues.value.end.round(),
       minHeight: currentRangeHeightValues.value.start.round(), maxHeight: currentRangeHeightValues.value.end.round(),
       minWeight: currentRangeWeightValues.value.start.round(), maxWeight: currentRangeWeightValues.value.end.round(),
       socialState: isArabe ? THelperFunctions.getSocialStateEnum(maritalStatusController.text) : maritalStatusController.text,
       marriageType: isArabe ? THelperFunctions.getMarriageTypeEnum(lookingForController.text) : lookingForController.text,
       country: selectedIdCountry, //countryToSend,
       //country: isArabe ? THelperFunctions.getCountryEnum(selectedPays.value!.name!) : selectedPays.value!.name,
     reset: true  //recommence la pagination à zero
   );

    Future.delayed(const Duration(milliseconds: 3000), (){
      //Remove Loader
      FullScreenLoader.stopLoading();
    });

  }

  ///LinearProgressIndicator Start
  /*
  // Ajout : Suivi de l'index courant pour les navigations programmatiques
  final RxInt currentIndex = 0.obs;
  int get cardsCount => users.length; // Getter pour la taille (performant)

  final CardSwiperController swiperController = CardSwiperController();
  final RxDouble progress = 0.0.obs;
  //Timer? autoSwipeTimer;
  Timer? progressTimer;

  void startAutoSwipe() {
    stopAutoSwipe();

    const swipeInterval = Duration(seconds: 10);
    const tickInterval = Duration(milliseconds: 100);
    const totalTicks = 10000 ~/ 100; // 10s -> 100 ticks

    int tickCount = 0;
    progress.value = 0;

    progressTimer = Timer.periodic(tickInterval, (timer) {
      tickCount++;
      progress.value = tickCount / totalTicks;
      if (tickCount >= totalTicks) {
        timer.cancel();

        // Modification : Swipe automatique vers un index ALÉATOIRE
        int nextIndex = Random().nextInt(cardsCount);
        if (nextIndex == currentIndex.value) {
          nextIndex = (currentIndex.value + 1) % cardsCount; // Évite la répétition
        }
        currentIndex.value = nextIndex;
        swiperController.moveTo(nextIndex); // Programmatique et fluide

        startAutoSwipe(); // Relance le cycle
      }
    });
  }

  void stopAutoSwipe() {
    //autoSwipeTimer?.cancel();
    progressTimer?.cancel(); //if add progess timer
  }

  /// 🔁 Appelé après chaque swipe (manuel ou auto)
  void onSwipe() {
    stopAutoSwipe();
    startAutoSwipe();
  }

  @override
  void onClose() {
    stopAutoSwipe();
    super.onClose();
  }
  */
  ///LinearProgressIndicator End
}