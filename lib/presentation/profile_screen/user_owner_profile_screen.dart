import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/controller/user_owner_profile_controller.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/fullscreen_image_viewer.dart';
import 'package:dating_app_bilhalal/widgets/circle_icon_button.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
import 'package:dating_app_bilhalal/widgets/grid_layout.dart';
import 'package:dating_app_bilhalal/widgets/home/tabbed_page_widget.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class UserOwnerProfileScreen extends GetView<UserOwnerProfileController> {
  const UserOwnerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenheight = mediaQueryData.size.height;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return SafeArea(
        child: Scaffold(
          //backgroundColor: PrefUtils().getThemeData() =='light' ? TColors.lightContainer : TColors.darkerGrey,
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
                  child: CircleIconButton(
                      size: 60.adaptSize,
                      effectiveSize: 60.adaptSize,
                      minTapSize: 60.adaptSize,
                      backgroundColor: TColors.greyDating.withOpacity(0.5),
                      child: IconButton(
                        icon: Icon(Icons.arrow_forward_outlined, color: TColors.white, size: 40.adaptSize,),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      )
                  ),
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
                      width: double.infinity,
                      height: screenheight * 0.6,
                      radius: 50.adaptSize,
                      isBorderRadiusTop: true,
                      padding: EdgeInsets.symmetric(
                        horizontal: TSizes.spaceBtwSections.hw,
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
                                    TitleWidget(title: 'نورا خالد', fontWeightDelta: 3, fontSizeDelta: 2,),

                                    CircleIconButton(
                                        size: 60.adaptSize,
                                        effectiveSize: 60.adaptSize,
                                        minTapSize: 60.adaptSize,
                                        backgroundColor: TColors.greyDating.withOpacity(0.5),
                                        child: IconButton(
                                          icon: Icon(Iconsax.share, color: TColors.textSecondary, size: 40.adaptSize,),
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
                                Text(
                                  "نموذج احترافي",
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

                                SizedBox(height: TSizes.spaceBtwItems.v),
                                CustomButtonContainer(
                                  text: "تعديل الملف الشخصي",
                                  color1: TColors.yellowAppDark,
                                  color2: TColors.yellowAppLight,
                                  borderRadius: 30,
                                  colorText: TColors.white,
                                  fontSize: 20.adaptSize,
                                  width: 220.adaptSize,
                                  onPressed: () async {
                                    Get.toNamed(Routes.overviewAccountScreen);
                                  },
                                ),
                                SizedBox(height: TSizes.spaceBtwSections.v),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TitleWidget(title: "الصور / الفيديوات", color: TColors.black, fontWeightDelta: 1, fontSizeDelta: 1),
                                    CustomButtonContainer(
                                      text:"حذف",
                                      color1: TColors.yellowAppDark,
                                      color2: TColors.yellowAppLight,
                                      borderRadius: 30,
                                      colorText: TColors.white,
                                      fontSize: 20.adaptSize,
                                      width: 120.adaptSize,
                                      onPressed: () async {
                                        Get.toNamed(Routes.mediaOwnerProfileScreen);
                                      },
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
                                  activeColor: TColors.yellowAppDark,
                                  inactiveColor: TColors.black,
                                ),
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
                                                    width: 40.adaptSize,
                                                    height: 40.adaptSize,
                                                    radius: 40.adaptSize,
                                                    backgroundColor: TColors.greyDating.withOpacity(0.9),
                                                    //margin: EdgeInsets.symmetric(horizontal: 10.hw),
                                                    child: IconButton(
                                                      icon: Icon(Iconsax.heart5, color: TColors.redAppLight, size: 20.adaptSize,),
                                                      onPressed: (){

                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(width: 5.adaptSize),
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