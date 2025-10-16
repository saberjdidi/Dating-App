
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/widgets/app_bar/appbar_widget.dart';
import 'package:dating_app_bilhalal/widgets/custom_divider.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatefulWidget {
   PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {

  var _appTheme = PrefUtils.getTheme();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: TColors.white,
      appBar: TAppBar(
        //showBackArrow: true,
        //rightToLeft: true,
       /* title: Text('سياسة الخصوصية',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: TColors.black,
            fontSize: 22.fSize,
            fontWeight: FontWeight.bold,
            //decoration: TextDecoration.underline,
            decorationColor: TColors.black,
          ),
        ), */
        title: TitleWidget(title: "سياسة الخصوصية", fontWeightDelta: 1,
            color: _appTheme =='light' ? TColors.buttonSecondary : TColors.white),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15.hw, 10.v, 15.hw, 5.v),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomDividerWidget(),
              SizedBox(height: TSizes.spaceBtwItems),
              TitleWidget(title: "سياسة الخصوصية",
                color:  _appTheme =='light' ? TColors.black : TColors.white,
                textAlign: TextAlign.right,),
              SubTitleWidget(subtitle: "آخر تحديث 3 يوليو 2025",
                color:  _appTheme =='light' ? TColors.gray700 : TColors.white,
                textAlign: TextAlign.right,),
              SizedBox(height: TSizes.spaceBtwItems),
              TRoundedContainer(
                //height: isTablet ? 20.hw : 52.hw,
                //width: isTablet ? 20.hw : 52.hw,
                //margin: EdgeInsets.only(top: 5),
                  showBorder: true,
                  backgroundColor: _appTheme =='light' ? TColors.white : TColors.dark,
                  borderColor: TColors.gray700,
                  radius: 12,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TitleWidget(title: "مقدمة",
                        color:  _appTheme =='light' ? TColors.black : TColors.white,
                        textAlign: TextAlign.right,),
                      SubTitleWidget(subtitle: "لكن لا بد أن أوضح لك أن كل هذه الأفكار المغلوطة حول استنكار  النشوة وتمجيد الألم نشأت بالفعل، وسأعرض لك التفاصيل لتكتشف حقيقة وأساس تلك السعادة البشرية، فلا أحد يرفض أو يكره أو يتجنب الشعور بالسعادة لكن لا بد أن أوضح لك أن كل هذه الأفكار المغلوطة حول استنكار  النشوة وتمجيد الألم نشأت بالفعل، وسأعرض لك التفاصيل لتكتشف حقيقة وأساس تلك السعادة البشرية، فلا أحد يرفض أو يكره أو يتجنب الشعور بالسعادة",
                        color:  _appTheme =='light' ? TColors.gray700 : TColors.white,
                        textAlign: TextAlign.right,),
                      SizedBox(height: TSizes.spaceBtwItems),

                      TitleWidget(title: "العنوان 2",
                        color:  _appTheme =='light' ? TColors.black : TColors.white,
                        textAlign: TextAlign.right,),
                      SubTitleWidget(subtitle: "لكن لا بد أن أوضح لك أن كل هذه الأفكار المغلوطة حول استنكار  النشوة وتمجيد الألم نشأت بالفعل، وسأعرض لك التفاصيل لتكتشف حقيقة وأساس تلك السعادة البشرية، فلا أحد يرفض أو يكره أو يتجنب الشعور بالسعادة",
                        color:  _appTheme =='light' ? TColors.gray700 : TColors.white,
                        textAlign: TextAlign.right,),
                      SizedBox(height: TSizes.spaceBtwItems),

                      TitleWidget(title: "العنوان3",
                        color:  _appTheme =='light' ? TColors.black : TColors.white,
                        textAlign: TextAlign.right,),
                      SubTitleWidget(subtitle: "لكن لا بد أن أوضح لك أن كل هذه الأفكار المغلوطة حول استنكار  النشوة وتمجيد الألم نشأت بالفعل، وسأعرض لك التفاصيل لتكتشف حقيقة وأساس تلك السعادة البشرية، فلا أحد يرفض أو يكره أو يتجنب الشعور بالسعادة",
                        color:  _appTheme =='light' ? TColors.gray700 : TColors.white,
                        textAlign: TextAlign.right,),
                      SizedBox(height: TSizes.spaceBtwItems),
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Navigates to the previous screen.
  onTapArrowLeft() { Get.back(); }
}
