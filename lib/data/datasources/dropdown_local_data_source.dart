import 'package:dating_app_bilhalal/data/models/selection_popup_model.dart';
import 'package:get/get.dart';

Rx<List<SelectionPopupModel>> ListMaritalStatus = Rx(
    [
      SelectionPopupModel(id:1,title:"أعزب"),
      SelectionPopupModel(id:2,title:"متزوج"),
      SelectionPopupModel(id:3,title:"مُطلّق"),
      SelectionPopupModel(id:4,title:"أرمل")
    ]
);

List<String> ListMaritalStatuss = ['single'.tr, 'married'.tr, 'divorced'.tr, 'widowed'.tr];
List<String> ListMaritalStatusFilter = ['all'.tr, 'single'.tr, 'married'.tr, 'divorced'.tr, 'widowed'.tr];
List<String> ListMarriageType = [ 'friend'.tr, 'date'.tr, 'living_partner'.tr, 'marriage'.tr];
List<String> ListMarriageTypeFilter = [ 'all'.tr, 'friend'.tr, 'date'.tr, 'living_partner'.tr, 'marriage'.tr];

Rx<List<SelectionPopupModel>> ListLookingFor = Rx(
    [
     SelectionPopupModel(id:1,title:"زواج معلن دائم"),
      SelectionPopupModel(id:2,title:"زواج سري دائم"),
      SelectionPopupModel(id:3,title:"آخر"),

      SelectionPopupModel(id:1,title:"مواعدة"),
      SelectionPopupModel(id:2,title:"زواج"),
      SelectionPopupModel(id:3,title:"معيشة"),
      SelectionPopupModel(id:3,title:"معيشة"),
      SelectionPopupModel(id:4,title:"الصداقة")
    ]
);

Rx<List<SelectionPopupModel>> ListPays = Rx(
    [
      SelectionPopupModel(id:1,title:"الكل"),
      SelectionPopupModel(id:2,title:"السعودیة"),
      SelectionPopupModel(id:3,title:"البحرین"),
      SelectionPopupModel(id:4,title:"الامارات"),
      SelectionPopupModel(id:5,title:"تونس"),
      SelectionPopupModel(id:6,title:"قطر"),
      SelectionPopupModel(id:7,title:"الکویت"),
      SelectionPopupModel(id:8,title:"العراق"),
      SelectionPopupModel(id:9,title:"عمان"),
      SelectionPopupModel(id:10,title:"المغرب"),
    ]
);

final ColorsSkinList = ['#5C4033', '#D2B48C', '#8D5524', '#C68642', '#E0AC69', '#FFC28B', '#FFD1A4', '#FFE0BD'];
//final ColorsSkinList = ['deep', 'tan', 'brown', 'olive', 'medium', 'light2', 'light', 'fair'];
final ColorsCallVideoList = ['filterColorCallVideo1', 'filterColorCallVideo2', 'filterColorCallVideo3', 'filterColorCallVideo4', 'filterColorCallVideo5'];