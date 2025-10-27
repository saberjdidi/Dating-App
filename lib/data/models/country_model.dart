import 'package:dating_app_bilhalal/core/app_export.dart';

class CountryModel {
  String? id;
  String? name;
  String? code;
  String? phoneCode;
  String? flag;
  bool? isActive;
  String? createdAt;
  String? updatedAt;
  //String? imagePath;

  CountryModel({
    this.id,
    this.name,
    this.code,
    this.phoneCode,
    this.flag,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    phoneCode = json['phone_code'];
    flag = json['flag'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['phone_code'] = this.phoneCode;
    data['flag'] = this.flag;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

final countriesList = [
  CountryModel(name: "البحرین", flag: ImageConstant.paysBahrayn),
  CountryModel(name: "الکل", flag: ImageConstant.logo),
  CountryModel(name: "الامارات", flag: ImageConstant.paysImarat),
  CountryModel(name: "قطر", flag: ImageConstant.paysQatar),
  CountryModel(name: "تونس", flag: ImageConstant.paysTunisia),
  CountryModel(name: "الکویت", flag: ImageConstant.paysKewait),
  CountryModel(name: "السعودیة", flag: ImageConstant.paysArabeSaoudite),
  CountryModel(name: "العراق", flag: ImageConstant.paysIraq),
  CountryModel(name: "عمان", flag: ImageConstant.paysOman),
  CountryModel(name: "المغرب", flag: ImageConstant.paysMarroc),
];

Rx<List<CountryModel>> PaysList = Rx(
    [
      CountryModel(name: "البحرین", flag: ImageConstant.paysBahrayn),
      CountryModel(name: "الامارات", flag: ImageConstant.paysImarat),
      CountryModel(name: "قطر", flag: ImageConstant.paysQatar),
      CountryModel(name: "تونس", flag: ImageConstant.paysTunisia),
      CountryModel(name: "الکویت", flag: ImageConstant.paysKewait),
      CountryModel(name: "السعودیة", flag: ImageConstant.paysArabeSaoudite),
      CountryModel(name: "العراق", flag: ImageConstant.paysIraq),
      CountryModel(name: "عمان", flag: ImageConstant.paysOman),
      CountryModel(name: "المغرب", flag: ImageConstant.paysMarroc),
      CountryModel(name: "لبنان", flag: ImageConstant.paysLubnan),
    ]
);

Rx<List<CountryModel>> PaysListFilter = Rx(
    [
      CountryModel(name: "الکل"),
      CountryModel(name: "البحرین", flag: ImageConstant.paysBahrayn),
      CountryModel(name: "الامارات", flag: ImageConstant.paysImarat),
      CountryModel(name: "قطر", flag: ImageConstant.paysQatar),
      CountryModel(name: "تونس", flag: ImageConstant.paysTunisia),
      CountryModel(name: "الکویت", flag: ImageConstant.paysKewait),
      CountryModel(name: "السعودیة", flag: ImageConstant.paysArabeSaoudite),
      CountryModel(name: "العراق", flag: ImageConstant.paysIraq),
      CountryModel(name: "عمان", flag: ImageConstant.paysOman),
      CountryModel(name: "المغرب", flag: ImageConstant.paysMarroc),
      CountryModel(name: "لبنان", flag: ImageConstant.paysLubnan),
    ]
);