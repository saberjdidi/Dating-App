import 'package:dating_app_bilhalal/core/app_export.dart';

class CountryModel {
  final String name;
  final String imagePath;

  CountryModel({
    required this.name,
    required this.imagePath,
  });
}

final countriesList = [
  CountryModel(name: "France", imagePath: ImageConstant.paysTunisia),
  CountryModel(name: "USA", imagePath: ImageConstant.paysTunisia),
  CountryModel(name: "Tunis", imagePath: ImageConstant.paysTunisia),
  CountryModel(name: "Qatar", imagePath: ImageConstant.paysTunisia),
  CountryModel(name: "Mali", imagePath: ImageConstant.paysTunisia),
  CountryModel(name: "Allemagne", imagePath: ImageConstant.paysTunisia),
  CountryModel(name: "Arabie Saoudite", imagePath: ImageConstant.paysTunisia),
];