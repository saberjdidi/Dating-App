import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/widgets/app_bar/appbar_widget.dart';
import 'package:dating_app_bilhalal/widgets/custom_dialog.dart';
import 'package:dating_app_bilhalal/widgets/custom_divider.dart';
import 'package:dating_app_bilhalal/widgets/custom_outlined_button.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class TermesAndConditionsScreen extends StatefulWidget {
  const TermesAndConditionsScreen({super.key});

  @override
  State<TermesAndConditionsScreen> createState() => _TermesAndConditionsScreenState();
}

class _TermesAndConditionsScreenState extends State<TermesAndConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      appBar: TAppBar(
        showBackArrow: true,
        rightToLeft: true,
        title: Text('شروط الاستخدام',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: TColors.black,
            fontSize: 22.fSize,
            fontWeight: FontWeight.bold,
            //decoration: TextDecoration.underline,
            decorationColor: TColors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15.hw, 10.v, 15.hw, 5.v),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomDividerWidget(),
              SizedBox(height: TSizes.spaceBtwItems),
              TitleWidget(title: "الشروط والأحكام", textAlign: TextAlign.right,),
              SubTitleWidget(subtitle: "آخر تحديث 3 يوليو 2025",
                textAlign: TextAlign.right,),
              SizedBox(height: TSizes.spaceBtwItems),
              TRoundedContainer(
                //height: isTablet ? 20.hw : 52.hw,
                //width: isTablet ? 20.hw : 52.hw,
                //margin: EdgeInsets.only(top: 5),
                showBorder: true,
                backgroundColor: TColors.white,
                borderColor: TColors.gray700,
                radius: 12,
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TitleWidget(title: "المصطلح 1", textAlign: TextAlign.right,),
                    SubTitleWidget(subtitle: "لكن لا بد أن أوضح لك أن كل هذه الأفكار المغلوطة حول استنكار  النشوة وتمجيد الألم نشأت بالفعل، وسأعرض لك التفاصيل لتكتشف حقيقة وأساس تلك السعادة البشرية، فلا أحد يرفض أو يكره أو يتجنب الشعور بالسعادة",
                      textAlign: TextAlign.right,),
                    SizedBox(height: TSizes.spaceBtwItems),

                    TitleWidget(title: "المصطلح 2", textAlign: TextAlign.right,),
                    SubTitleWidget(subtitle: "لكن لا بد أن أوضح لك أن كل هذه الأفكار المغلوطة حول استنكار  النشوة وتمجيد الألم نشأت بالفعل، وسأعرض لك التفاصيل لتكتشف حقيقة وأساس تلك السعادة البشرية، فلا أحد يرفض أو يكره أو يتجنب الشعور بالسعادة",
                      textAlign: TextAlign.right,),
                    SizedBox(height: TSizes.spaceBtwItems),

                    TitleWidget(title: "المصطلح 2", textAlign: TextAlign.right,),
                    SubTitleWidget(subtitle: "لكن لا بد أن أوضح لك أن كل هذه الأفكار المغلوطة حول استنكار  النشوة وتمجيد الألم نشأت بالفعل، وسأعرض لك التفاصيل لتكتشف حقيقة وأساس تلك السعادة البشرية، فلا أحد يرفض أو يكره أو يتجنب الشعور بالسعادة",
                      textAlign: TextAlign.right,),
                    SizedBox(height: TSizes.xs.v),
                  ],
                )
              ),
              SizedBox(height: TSizes.xs.v),
             Directionality(
               textDirection: TextDirection.rtl,
               child: Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   CustomButtonContainer(
                     height: 70.v,
                     width: Get.width * 0.4,
                     text: "يقبل",
                     color1: TColors.greenAccept,
                     color2: TColors.greenAccept,
                     borderRadius: 10,
                     colorText: TColors.white,
                     fontSize: 20.adaptSize,
                     onPressed: () async {
                       DialogAcceptTermsAndConditions(context);
                     },
                   ),
                   CustomOutlinedButton(
                     width: Get.width * 0.4,
                     height: 70.v,
                     buttonTextStyle: CustomTextStyles.bodyMediumTextFormField,
                     buttonStyle: CustomButtonStyles.outlineBlack,
                     text: "لا أوافق",
                     margin: EdgeInsets.only(top: 6.hw),
                     onPressed: (){

                     },
                   )
                 ],
               ),
             )
             /* Text("les_terme_condition".tr,
                  style: Theme.of(context).textTheme.titleLarge!.apply(color: TColors.black, fontWeightDelta: 1, fontSizeDelta: 2)),
              SizedBox(height: 20.v),
              Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                style: theme.textTheme.displayMedium!.copyWith(
                    color: TColors.black,
                    fontSize: 17.adaptSize,
                    fontFamily: 'Poppins'
                ),
                textAlign: TextAlign.justify,
                overflow: TextOverflow.fade,
              ), */
            ],
          ),
        ),
      ),
    );
  }
  /// Navigates to the previous screen.
  onTapArrowLeft() { Get.back(); }

  DialogAcceptTermsAndConditions(BuildContext context){
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (builder) =>
            CustomDialog(
              icon: Icons.close,
              onCancel: onTapArrowLeft,
              onTap: (){},
              //cancelText: "lbl_no".tr,
              successText: "يقبل".tr,
              title: "تنصل".tr,
              description: "لا يمكنك المتابعة دون قبول الشروط والأحكام".tr,
              descriptionTextStyle: CustomTextStyles.titleSmallGray400,
              image: ImageConstant.imgWarning,
            )
    );
  }
}
