import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/interest_model.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/controller/profile_details_controller.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/fullscreen_image_viewer.dart';
import 'package:dating_app_bilhalal/widgets/account/interest_widget.dart';
import 'package:dating_app_bilhalal/widgets/chat/user_stats_widget.dart';
import 'package:dating_app_bilhalal/widgets/circle_icon_button.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
import 'package:dating_app_bilhalal/widgets/grid_layout.dart';
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
    var screenHeight = mediaQueryData.size.height;
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
                  imagePath: controller.userModel.imageProfile,
                  //height: 200.adaptSize,
                  //width: 200.adaptSize,
                  fit: BoxFit.cover,
                ),
              ),

              // Image en haut à gauche
              Positioned(
                top: 20,
                left: 20,
                child:  CircleIconButton(
                  size: isSmallPhone ? 70.adaptSize : 60.adaptSize,
                  effectiveSize: isSmallPhone ? 70.adaptSize : 60.adaptSize,
                  minTapSize: 60.adaptSize,
                  backgroundColor: TColors.greyDating.withOpacity(0.5),
                  child: IconButton(
                    icon: Icon(Icons.share_outlined, color: TColors.white, size: 40.adaptSize,),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                )
              ),

              // Image en haut à droite
              Positioned(
                top: 20,
                right: 20,
                child: CircleIconButton(
                  size: isSmallPhone ? 70.adaptSize : 60.adaptSize,
                  effectiveSize: isSmallPhone ? 70.adaptSize : 60.adaptSize,
                  minTapSize: 60.adaptSize,
                  backgroundColor: TColors.greyDating.withOpacity(0.5),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_outlined, color: TColors.white, size: 40.adaptSize,),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                )
              ),


              // Conteneur avec infos utilisateur
              Align(
                alignment: Alignment.bottomCenter,
                child: TRoundedContainer(
                  width: double.infinity,
                  height: screenHeight * 0.6,
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TitleWidget(title: '${controller.userModel.fullName}، ${controller.userModel.age} عاما'),
                            SizedBox(height: 6.v),
                            // job - allow up to 2 lines then ellipsis
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.iconJob,
                                  //height: 200.adaptSize,
                                  //width: 200.adaptSize,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(width: 10.adaptSize),
                                Text(
                                  controller.userModel.bio,
                                  textAlign: TextAlign.right,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: isTablet ? 17.adaptSize : 16.adaptSize,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 6.v),
                            // bio - allow up to 2 lines then ellipsis
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.iconLocation,
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
                                    color: Colors.black,
                                    fontSize: isTablet ? 17.adaptSize : 16.adaptSize,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(height: TSizes.spaceBtwItems.v),
                            UserStatsWidget(
                              height: "172 cm",
                              weight: "60 kg",
                              salary: "110K - 600K",
                              skinColor: "skinColor3",
                              iconSize: 30,
                            ),

                            SizedBox(height: 10.v),
                            SubTitleWidget(subtitle: "بایو:", color: TColors.black, fontWeightDelta: 4, fontSizeDelta: 5,),
                            SubTitleWidget(subtitle: "اسمي جيسيكا باركر، وأستمتع بلقاء أشخاص جدد وإيجاد طرق لمساعدتهم على خوض تجربة إيجابية. أستمتع بالقراءة....اقرأ المزيد",
                              color: TColors.black, textAlign: TextAlign.right,),

                            SizedBox(height: 20.v),
                            SubTitleWidget(subtitle: "الاهتمامات", color: TColors.black, fontWeightDelta: 4, fontSizeDelta: 5,),
                            GridView.count(
                                crossAxisCount: isTablet ? 3 : 2, // ✅ Deux colonnes fixes
                                mainAxisSpacing: 2,
                                crossAxisSpacing: 3,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(), // Empêche le scroll dans un Column
                                childAspectRatio: 2, // ✅ contrôle la largeur/hauteur
                                children: (controller.userModel.interests ?? []).map((interestName) {
                                  return InterestWidget(
                                    text: interestName,
                                    iconPath: InterestModel.getIconByName(interestName),
                                    isSelected: true,
                                    activeColor: false,
                                    onTap: () {},
                                  );
                                }).toList()
                            ),

                            SizedBox(height: 20.v),
                            SubTitleWidget(subtitle: "معرض", color: TColors.black, fontWeightDelta: 4, fontSizeDelta: 5,),
                            GridLayout(
                              itemCount: controller.userModel.images!.length, // +1 pour l'upload
                              mainAxisExtent: isTablet ? 220.adaptSize : 180.adaptSize,
                              crossAxisCount: 3,
                              itemBuilder: (context, index) {
                                final image = controller.userModel.images![index]; // -1 car le 1er est upload
                                return TRoundedContainer(
                                  showBorder: true,
                                  backgroundColor: TColors.white,
                                  borderColor: TColors.greyDating,
                                  radius: 12,
                                  padding: EdgeInsets.all(1),
                                  child: CustomImageView(
                                    //file: file,
                                    imagePath: image,
                                    //imagePath: file.path, // très important: .path car File
                                    height: Get.height,
                                    width: Get.width,
                                    fit: BoxFit.cover,
                                    radius: BorderRadius.circular(10),
                                    onTap: (){
                                      Get.to(() => FullScreenImageViewer(
                                        images: controller.userModel.images!,
                                        initialIndex: index,
                                      ));
                                    },
                                  ),
                                );
                              },
                            ),

                            SizedBox(height: TSizes.spaceBtwSections.v),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                CustomImageView(
                                  imagePath: ImageConstant.profileLove,
                                  //height: Get.height,
                                  //width: Get.width,
                                  fit: BoxFit.cover,
                                ),
                                CustomImageView(
                                  imagePath: ImageConstant.profileChat,
                                  //height: Get.height,
                                  //width: Get.width,
                                  fit: BoxFit.cover,
                                ),
                                CustomImageView(
                                  imagePath: ImageConstant.profileRemove,
                                  //height: Get.height,
                                  //width: Get.width,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            )
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
