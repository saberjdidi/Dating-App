import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/controller/profile_details_controller.dart';
import 'package:dating_app_bilhalal/widgets/app_bar/appbar_widget.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class ProfileDetailsScreen extends GetView<ProfileDetailsController> {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenheight = mediaQueryData.size.height;

    return SafeArea(
        child: Scaffold(
          backgroundColor: PrefUtils().getThemeData() =='light' ? TColors.lightContainer : TColors.darkerGrey,
          resizeToAvoidBottomInset: false,
         /* appBar: TAppBar(
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
          ), */
          body: Stack(
            children: [
              // background image (fills)
              Positioned.fill(
                child: CustomImageView(
                  imagePath: controller.userModel.imageProfile,
                  //height: 200.adaptSize,
                  //width: 200.adaptSize,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: TRoundedContainer(
                  width: double.infinity,
                  height: screenheight * 0.5,
                  radius: 50.adaptSize,
                  isBorderRadiusTop: true,
                  padding: EdgeInsets.symmetric(
                    horizontal: TSizes.spaceBtwSections.hw,
                    vertical: TSizes.spaceBtwItems.v,
                  ),
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TitleWidget(title: '${controller.userModel.fullName}، ${controller.userModel.age} عاما'),
                          SizedBox(height: 6.v),
                          // bio - allow up to 2 lines then ellipsis
                          Text(
                            controller.userModel.bio,
                            textAlign: TextAlign.right,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 6.v),
                          // bio - allow up to 2 lines then ellipsis
                          Text(
                            "المملكة العربية السعودية",
                            textAlign: TextAlign.right,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(height: 10.v),
                          SubTitleWidget(subtitle: "بایو:", color: TColors.black, fontWeightDelta: 4, fontSizeDelta: 5,),
                          SubTitleWidget(subtitle: "اسمي جيسيكا باركر، وأستمتع بلقاء أشخاص جدد وإيجاد طرق لمساعدتهم على خوض تجربة إيجابية. أستمتع بالقراءة....اقرأ المزيد",
                            color: TColors.black, textAlign: TextAlign.right,),

                          SizedBox(height: 10.v),
                          SubTitleWidget(subtitle: "الاهتمامات", color: TColors.black, fontWeightDelta: 4, fontSizeDelta: 5,),
                        ],
                      )
                  )
                ),
              ),
            ],
          )
        )
    );
  }
}
