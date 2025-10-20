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

Rx<List<SelectionPopupModel>> ListMaritalStatusFilter = Rx(
    [
      SelectionPopupModel(id:1,title:"الكل"),
      SelectionPopupModel(id:2,title:"أعزب"),
      SelectionPopupModel(id:3,title:"متزوج"),
      SelectionPopupModel(id:4,title:"مُطلّق"),
      SelectionPopupModel(id:5,title:"أرمل")
    ]
);

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

Rx<List<SelectionPopupModel>> ListLookingForFilter = Rx(
    [
      SelectionPopupModel(id:1,title:"الكل"),
      SelectionPopupModel(id:2,title:"زواج معلن دائم"),
      SelectionPopupModel(id:3,title:"زواج سري دائم"),
      SelectionPopupModel(id:4,title:"آخر"),
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

final ColorsSkinList = ['Deep', 'Tan', 'Brown', 'Olive', 'Medium', 'Light2', 'Light', 'Fair'];
final ColorsCallVideoList = ['filterColorCallVideo1', 'filterColorCallVideo2', 'filterColorCallVideo3', 'filterColorCallVideo4', 'filterColorCallVideo5'];