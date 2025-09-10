import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/onboarding_screen/model/onboarding_model.dart';

List<OnboardingModel> onBoardingList = [
  OnboardingModel(
      title: "Votre application vers les enchères immobilières",
      body: "Accédez rapidement aux enchères en cours. Découvrez une interface intuitive pour explorer des offres propriétés au Canada.",
      image: ImageConstant.imgOnBoarding1
    //image: ImageConstant.imgOnBoarding1
  ),
  OnboardingModel(
      title: "Trouvez la propriété parfaite en quelques étapes",
      body: "Parcourez nos annonces immobilières et trouvez votre prochaine aventure immobilière avec notre recherche rapide",
      image: ImageConstant.imgOnBoarding2
  ),
  OnboardingModel(
      title: "Misez facilement sur vos propriétés préférées",
      body: "Naviguez parmi les enchères en cours et misez sans effort sur les propriétés qui vous intéressent.",
      image: ImageConstant.imgOnBoarding3
  ),
];