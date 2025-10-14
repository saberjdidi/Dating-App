import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/controller/user_owner_profile_controller.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/fullscreen_image_viewer.dart';
import 'package:dating_app_bilhalal/widgets/chat/user_stats_widget.dart';
import 'package:dating_app_bilhalal/widgets/circle_icon_button.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
import 'package:dating_app_bilhalal/widgets/grid_layout.dart';
import 'package:dating_app_bilhalal/widgets/home/tabbed_page_widget.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class UserOwnerProfileScreen extends GetView<UserOwnerProfileController> {
   UserOwnerProfileScreen({super.key});

   var _appTheme = PrefUtils.getTheme();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenheight = mediaQueryData.size.height;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return SafeArea(
        top: false,
        child: Scaffold(
          //backgroundColor: PrefUtils.getTheme() =='light' ? TColors.lightContainer : TColors.darkerGrey,
            resizeToAvoidBottomInset: false,

            body: Stack(
              children: [
                // background image (fills)
                Positioned.fill(
                  child: CustomImageView(
                    imagePath: ImageConstant.profile8,
                    //height: 200.adaptSize,
                    //width: 200.adaptSize,
                    fit: BoxFit.cover,
                  ),
                ),

                // Image en haut à droite
                Positioned(
                  top: 20,
                  right: 20,
                 child: IconButton(
                   icon: Icon(Icons.arrow_forward_outlined, color: TColors.white, size: 35.hw),
                   onPressed: (){
                     Navigator.pop(context);
                   },
                 ),
                 /* child: CircleIconButton(
                      size: 60.hw,
                      effectiveSize: 60.hw,
                      minTapSize: 60.hw,
                      backgroundColor: TColors.greyDating.withOpacity(0.5),
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward_outlined, color: TColors.white, size: isSmallPhone ? 35.hw : 40.hw),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      )
                  ), */
                ),
              /*  Positioned(
                    top: 20,
                    right: 20,
                    child: CircularContainer(
                      width: 60.adaptSize,
                      height: 60.adaptSize,
                      radius: 60.adaptSize,
                      backgroundColor: TColors.greyDating.withOpacity(0.5),
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward_outlined, color: TColors.white, size: 40.adaptSize,),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      ),
                    )
                ), */


                // Conteneur avec infos utilisateur
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TRoundedContainer(
                      backgroundColor: _appTheme =='light' ? TColors.white : TColors.dark,
                      width: double.infinity,
                      height: screenheight * 0.6,
                      radius: 50.adaptSize,
                      isBorderRadiusTop: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: TSizes.spaceBtwItems.hw,
                        vertical: TSizes.spaceBtwItems.v,
                      ),
                      child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(''),
                                    TitleWidget(title: 'نورا خالد', fontWeightDelta: 3, fontSizeDelta: 2,
                                        color: _appTheme =='light' ? TColors.black : TColors.white),

                                    CircleIconButton(
                                        size: 60.hw,
                                        effectiveSize: 60.hw,
                                        minTapSize: 60.hw,
                                        backgroundColor: TColors.greyDating.withOpacity(0.5),
                                        child: IconButton(
                                          icon: Icon(Iconsax.share, color: _appTheme =='light' ? TColors.textSecondary : TColors.white, size: 40.hw,),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                        )
                                    ),
                                  /*  CircularContainer(
                                      width: 60.adaptSize,
                                      height: 60.adaptSize,
                                      radius: 60.adaptSize,
                                      backgroundColor: TColors.greyDating.withOpacity(0.5),
                                      child: IconButton(
                                        icon: Icon(Iconsax.share, color: TColors.textSecondary, size: 45.adaptSize,),
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ) */

                                  ],
                                ),
                                SizedBox(height: 6.v),
                                // bio - allow up to 2 lines then ellipsis
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomImageView(
                                      imagePath: ImageConstant.iconJob,
                                      color: _appTheme =='light' ? TColors.darkerGrey : TColors.white,
                                      //height: 200.adaptSize,
                                      //width: 200.adaptSize,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(width: 10.adaptSize),
                                    Text(
                                      "نموذج احترافي",
                                      textAlign: TextAlign.right,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: _appTheme =='light' ? TColors.darkerGrey : TColors.white,
                                        fontSize: isTablet ? 17.adaptSize : 16.adaptSize,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6.v),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomImageView(
                                      imagePath: ImageConstant.iconLocation,
                                      color: _appTheme =='light' ? TColors.darkerGrey : TColors.white,
                                      //height: 200.adaptSize,
                                      //width: 200.adaptSize,
                                      fit: BoxFit.cover,
                                    ),
                                    SizedBox(width: 10.adaptSize),
                                    Text(
                                      "المملكة العربية السعودية",
                                      textAlign: TextAlign.right,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: _appTheme =='light' ? TColors.darkerGrey : TColors.white,
                                        fontSize: isTablet ? 17.adaptSize : 16.adaptSize,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: TSizes.spaceBtwItems.v),
                                CustomButtonContainer(
                                  text: "تعديل الملف الشخصي",
                                  color1: TColors.primaryColorApp,
                                  color2: TColors.primaryColorApp,
                                  borderRadius: 30,
                                  colorText: TColors.white,
                                  fontSize: isTablet ? 30.adaptSize : 22.adaptSize,
                                  height: isSmallPhone ? 75.v : 65.v,
                                  width: isTablet ? Get.width * 0.5 : Get.width * 0.65,
                                  onPressed: () async {
                                    Get.toNamed(Routes.overviewAccountScreen);
                                  },
                                ),
                                SizedBox(height: TSizes.spaceBtwItems.v),
                                UserStatsWidget(
                                  height: "172 cm",
                                  weight: "60 kg",
                                  salary: "110K - 600K",
                                  skinColor: "skinColor3",
                                  iconSize: 30,
                                ),

                                SizedBox(height: TSizes.spaceBtwSections.v),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TitleWidget(title: "الصور / الفيديوات", color: _appTheme =='light' ? TColors.black : TColors.white, fontWeightDelta: 1, fontSizeDelta: 1),
                                    CustomButtonContainer(
                                      text:"حذف",
                                      color1: TColors.primaryColorApp,
                                      color2: TColors.primaryColorApp,
                                      borderRadius: 30,
                                      colorText: TColors.white,
                                      fontSize: isTablet ? 30.adaptSize : 22.adaptSize,
                                      height: isSmallPhone ? 65.v : isTablet ? 55.v : 40.v,
                                      width: 120.adaptSize,
                                      onPressed: () async {
                                        Get.toNamed(Routes.mediaOwnerProfileScreen);
                                      },
                                        paddingVertical: 2
                                    ),
                                  ],
                                ),
                                SizedBox(height: TSizes.spaceBtwItems.v),
                                TabbedPageWidget(
                                  tabs: [
                                    TabItem("الکل"),
                                    TabItem("صور"),
                                    TabItem("أشرطة الفيديو"),
                                  ],
                                  onTabChanged: controller.onTabChanged,
                                  activeColor: TColors.primaryColorApp, //TColors.yellowAppDark,
                                  inactiveColor: _appTheme =='light' ? TColors.black : TColors.white,
                                ),
                                SizedBox(height: 5.v),
                                GridLayout(
                                  itemCount: controller.ListImages.value.length,
                                  mainAxisExtent: isTablet ? 220.adaptSize : 180.adaptSize,
                                  crossAxisCount: 3,
                                  itemBuilder: (context, index) {
                                    final image = controller.ListImages.value[index]; // -1 car le 1er est upload
                                    return TRoundedContainer(
                                      showBorder: true,
                                      backgroundColor: TColors.white,
                                      borderColor: TColors.greyDating,
                                      radius: 12,
                                      padding: EdgeInsets.all(1),
                                      child: Stack(
                                        children: [
                                          CustomImageView(
                                            //file: file,
                                            imagePath: image,
                                            //imagePath: file.path, // très important: .path car File
                                            height: Get.height,
                                            width: Get.width,
                                            fit: BoxFit.cover,
                                            radius: BorderRadius.circular(10),
                                            onTap: (){
                                              Get.to(() => FullScreenImageViewer(
                                                images: controller.ListImages.value,
                                                initialIndex: index,
                                              ));
                                            },
                                          ),
                                          Positioned(
                                              bottom: 5,
                                              right: 5,
                                              child: Row(
                                                children: [
                                                  CircularContainer(
                                                    width: isTablet ? 40.adaptSize : 27,
                                                    height:  isTablet ? 40.adaptSize : 27,
                                                    radius:  isTablet ? 40.adaptSize : 27,
                                                    backgroundColor: TColors.greyDating.withOpacity(0.9),
                                                    //margin: EdgeInsets.symmetric(horizontal: 10.hw),
                                                    child: IconButton(
                                                      icon: Icon(Iconsax.heart5, color: TColors.redAppLight, size:  isTablet ? 20.adaptSize : 12),
                                                      onPressed: (){

                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(width: 3.adaptSize),
                                                  SubTitleWidget(subtitle: '23 إعجابًا', color: TColors.white, fontWeightDelta: 2,),
                                                ],
                                              )
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),

                                SizedBox(height: TSizes.spaceBtwSections.v),

                              ],
                            ),
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