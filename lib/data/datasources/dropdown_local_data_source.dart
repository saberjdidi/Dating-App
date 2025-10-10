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

Rx<List<SelectionPopupModel>> ListLookingFor = Rx(
    [
      SelectionPopupModel(id:1,title:"زواج معلن دائم"),
      SelectionPopupModel(id:2,title:"زواج سري دائم"),
      SelectionPopupModel(id:3,title:"آخر"),
     /* SelectionPopupModel(id:1,title:"مواعدة"),
      SelectionPopupModel(id:2,title:"زواج"),
      SelectionPopupModel(id:3,title:"معيشة"),
      SelectionPopupModel(id:4,title:"الصداقة") */
    ]
);

Rx<List<SelectionPopupModel>> ListPays = Rx(
    [
      SelectionPopupModel(id:1,title:"السعودیة"),
      SelectionPopupModel(id:2,title:"البحرین"),
      SelectionPopupModel(id:3,title:"الامارات"),
      SelectionPopupModel(id:4,title:"تونس"),
      SelectionPopupModel(id:4,title:"قطر"),
      SelectionPopupModel(id:4,title:"الکویت"),
      SelectionPopupModel(id:4,title:"العراق"),
      SelectionPopupModel(id:4,title:"عمان"),
      SelectionPopupModel(id:4,title:"المغرب"),
    ]
);

final ColorsSkinList = ['skinColor8', 'skinColor7', 'skinColor6', 'skinColor5', 'skinColor4', 'skinColor3', 'skinColor2', 'skinColor1'];
final ColorsCallVideoList = ['filterColorCallVideo1', 'filterColorCallVideo2', 'filterColorCallVideo3', 'filterColorCallVideo4', 'filterColorCallVideo5'];