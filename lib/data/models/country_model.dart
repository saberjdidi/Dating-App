import 'package:dating_app_bilhalal/core/app_export.dart';

class CountryModel {
  final String name;
  final String? imagePath;

  CountryModel({
    required this.name,
    this.imagePath,
  });
}

final countriesList = [
  CountryModel(name: "البحرین", imagePath: ImageConstant.paysBahrayn),
  CountryModel(name: "الکل", imagePath: ImageConstant.logo),
  CountryModel(name: "الامارات", imagePath: ImageConstant.paysImarat),
  CountryModel(name: "قطر", imagePath: ImageConstant.paysQatar),
  CountryModel(name: "تونس", imagePath: ImageConstant.paysTunisia),
  CountryModel(name: "الکویت", imagePath: ImageConstant.paysKewait),
  CountryModel(name: "السعودیة", imagePath: ImageConstant.paysArabeSaoudite),
  CountryModel(name: "العراق", imagePath: ImageConstant.paysIraq),
  CountryModel(name: "عمان", imagePath: ImageConstant.paysOman),
  CountryModel(name: "المغرب", imagePath: ImageConstant.paysMarroc),
];

Rx<List<CountryModel>> PaysList = Rx(
    [
      CountryModel(name: "الکل"),
      CountryModel(name: "البحرین", imagePath: ImageConstant.paysBahrayn),
      CountryModel(name: "الامارات", imagePath: ImageConstant.paysImarat),
      CountryModel(name: "قطر", imagePath: ImageConstant.paysQatar),
      CountryModel(name: "تونس", imagePath: ImageConstant.paysTunisia),
      CountryModel(name: "الکویت", imagePath: ImageConstant.paysKewait),
      CountryModel(name: "السعودیة", imagePath: ImageConstant.paysArabeSaoudite),
      CountryModel(name: "العراق", imagePath: ImageConstant.paysIraq),
      CountryModel(name: "عمان", imagePath: ImageConstant.paysOman),
      CountryModel(name: "المغرب", imagePath: ImageConstant.paysMarroc),
    ]
);