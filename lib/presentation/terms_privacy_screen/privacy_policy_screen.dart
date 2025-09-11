
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/widgets/app_bar/appbar_widget.dart';
import 'package:dating_app_bilhalal/widgets/custom_divider.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.white,
      appBar: TAppBar(
        showBackArrow: true,
        rightToLeft: true,
        title: Text('سياسة الخصوصية',
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
              TitleWidget(title: "سياسة الخصوصية", textAlign: TextAlign.right,),
              SubTitleWidget(subtitle: "آخر تحديث 3 يوليو 2025",
                textAlign: TextAlign.right,),
              SizedBox(height: TSizes.spaceBtwItems),
              TRoundedContainer(
                //height: isTablet ? 20.hw : 52.hw,
                //width: isTablet ? 20.hw : 52.hw,
                //margin: EdgeInsets.only(top: 5),
                  backgroundColor: TColors.white,
                  borderColor: TColors.gray700,
                  radius: 12,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TitleWidget(title: "مقدمة", textAlign: TextAlign.right,),
                      SubTitleWidget(subtitle: "لكن لا بد أن أوضح لك أن كل هذه الأفكار المغلوطة حول استنكار  النشوة وتمجيد الألم نشأت بالفعل، وسأعرض لك التفاصيل لتكتشف حقيقة وأساس تلك السعادة البشرية، فلا أحد يرفض أو يكره أو يتجنب الشعور بالسعادة لكن لا بد أن أوضح لك أن كل هذه الأفكار المغلوطة حول استنكار  النشوة وتمجيد الألم نشأت بالفعل، وسأعرض لك التفاصيل لتكتشف حقيقة وأساس تلك السعادة البشرية، فلا أحد يرفض أو يكره أو يتجنب الشعور بالسعادة",
                        textAlign: TextAlign.right,),
                      SizedBox(height: TSizes.spaceBtwItems),

                      TitleWidget(title: "العنوان 2", textAlign: TextAlign.right,),
                      SubTitleWidget(subtitle: "لكن لا بد أن أوضح لك أن كل هذه الأفكار المغلوطة حول استنكار  النشوة وتمجيد الألم نشأت بالفعل، وسأعرض لك التفاصيل لتكتشف حقيقة وأساس تلك السعادة البشرية، فلا أحد يرفض أو يكره أو يتجنب الشعور بالسعادة",
                        textAlign: TextAlign.right,),
                      SizedBox(height: TSizes.spaceBtwItems),

                      TitleWidget(title: "العنوان3", textAlign: TextAlign.right,),
                      SubTitleWidget(subtitle: "لكن لا بد أن أوضح لك أن كل هذه الأفكار المغلوطة حول استنكار  النشوة وتمجيد الألم نشأت بالفعل، وسأعرض لك التفاصيل لتكتشف حقيقة وأساس تلك السعادة البشرية، فلا أحد يرفض أو يكره أو يتجنب الشعور بالسعادة",
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
