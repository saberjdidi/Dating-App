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
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';

class ProfileDetailsScreen extends GetView<ProfileDetailsController> {
   ProfileDetailsScreen({super.key});

  var _appTheme = PrefUtils.getTheme();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenHeight = mediaQueryData.size.height;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return SafeArea(
        top: false,
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
                  size: isSmallPhone ? 70.hw : isTablet ? 65.hw : 60.hw,
                  effectiveSize: isSmallPhone ? 70.hw : 60.hw,
                  minTapSize: 60.hw,
                  backgroundColor: TColors.greyDating.withOpacity(0.5),
                  child: IconButton(
                    icon: Icon(Icons.share_outlined, color: TColors.white, size: 40.hw,),
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
                  size: isSmallPhone ? 70.hw : 60.hw,
                  effectiveSize: isSmallPhone ? 70.hw : 60.hw,
                  minTapSize: 60.hw,
                  backgroundColor: TColors.greyDating.withOpacity(0.5),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_outlined, color: TColors.white, size: 40.hw,),
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
                  backgroundColor: _appTheme =='light' ? TColors.white : TColors.dark,
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
                            TitleWidget(title: '${controller.userModel.fullName}، ${controller.userModel.age} عاما',
                            color: _appTheme =='light' ? TColors.black : TColors.white),
                            SizedBox(height: 6.v),
                            // job - allow up to 2 lines then ellipsis
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                                  controller.userModel.bio,
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
                            // bio - allow up to 2 lines then ellipsis
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
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
                            UserStatsWidget(
                              height: "172 cm",
                              weight: "60 kg",
                              salary: "110K - 600K",
                              skinColor: "skinColor3",
                              iconSize: 30,
                            ),

                            SizedBox(height: 10.v),
                            SubTitleWidget(subtitle: "بایو:", color: _appTheme =='light' ? TColors.black : TColors.white, fontWeightDelta: 4, fontSizeDelta: 5,),
                            ReadMoreText(
                              "اسمي جيسيكا باركر، وأستمتع بلقاء أشخاص جدد وإيجاد طرق لمساعدتهم على خوض تجربة إيجابية. اسمي جيسيكا باركر، وأستمتع بلقاء أشخاص جدد وإيجاد طرق لمساعدتهم على خوض تجربة إيجابية.",
                              trimMode: TrimMode.Line,
                              trimLines: 3,
                              trimLength: 240,
                              //preDataText: 'avant de text',
                              //preDataTextStyle: const TextStyle(fontWeight: FontWeight.w500),
                              style: TextStyle(fontSize: 17.adaptSize, color:  _appTheme =='light' ? TColors.black : TColors.white),
                              //style: Theme.of(context).textTheme.bodyMedium!.apply(color: _appTheme =='light' ? TColors.black : TColors.white, fontSizeDelta: 1, fontWeightDelta: 1),
                              colorClickableText: Colors.blue,
                              trimCollapsedText: 'اقرأ المزيد',
                              trimExpandedText: ' إظهار أقل',
                              moreStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                              lessStyle:  TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                            ),
                           // SubTitleWidget(subtitle: "اسمي جيسيكا باركر، وأستمتع بلقاء أشخاص جدد وإيجاد طرق لمساعدتهم على خوض تجربة إيجابية. أستمتع بالقراءة....اقرأ المزيد", color: _appTheme =='light' ? TColors.black : TColors.white, textAlign: TextAlign.right,),

                            SizedBox(height: 20.v),
                            SubTitleWidget(subtitle: "الاهتمامات", color: _appTheme =='light' ? TColors.black : TColors.white, fontWeightDelta: 4, fontSizeDelta: 5,),
                            Wrap(
                              spacing: 8, // Espace horizontal entre les items
                              runSpacing: 8, // Espace vertical entre les lignes
                              alignment: WrapAlignment.start,
                              children: (controller.userModel.interests ?? []).map((interestName) {
                                return InterestWidget(
                                  text: interestName,
                                  iconPath: InterestModel.getIconByName(interestName),
                                  isSelected: true,
                                  activeColor: false,
                                  onTap: () {},
                                );
                              }).toList(),
                            ),
                          /*  GridView.count(
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
                            ), */

                            SizedBox(height: 20.v),
                            SubTitleWidget(subtitle: "معرض", color: _appTheme =='light' ? TColors.black : TColors.white, fontWeightDelta: 4, fontSizeDelta: 5,),
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
                                CircleIconButton(
                                  size: isSmallPhone ? 80.hw : 75.hw,
                                  minTapSize: isSmallPhone ? 80.hw : 75.hw,
                                  effectiveSize: isSmallPhone ? 80.hw : 75.hw,
                                  backgroundColor: _appTheme =='light' ? TColors.greyDating.withOpacity(0.5) : TColors.dark,
                                  showBorder: true,
                                  borderColor: _appTheme =='light' ? TColors.white : TColors.buttonSecondary,
                                  child: CustomImageView(
                                    imagePath: ImageConstant.iconLove,
                                    //height: 35.hw,
                                    //width: 35.hw,
                                    fit: BoxFit.cover,
                                    color: Color(0xECA90606),
                                  ),
                                ),
                                CircleIconButton(
                                  size: isSmallPhone ? 110.hw : 100.hw,
                                  minTapSize: isSmallPhone ? 110.hw : 100.hw,
                                  effectiveSize: isSmallPhone ? 110.hw : 100.hw,
                                  backgroundColor: TColors.greyDating.withOpacity(0.5),
                                  showBorder: true,
                                  borderColor: TColors.yellowAppDark,
                                  child: CustomImageView(
                                    imagePath: ImageConstant.iconChat,
                                    //height: 50.hw,
                                    //width: 50.hw,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                CircleIconButton(
                                  size: isSmallPhone ? 80.hw : 75.hw,
                                  minTapSize: isSmallPhone ? 80.hw : 75.hw,
                                  effectiveSize: isSmallPhone ? 80.hw : 75.hw,
                                  backgroundColor: _appTheme =='light' ? TColors.greyDating.withOpacity(0.5) : TColors.dark,
                                  showBorder: true,
                                  borderColor: _appTheme =='light' ? TColors.white : TColors.buttonSecondary,
                                  child: CustomImageView(
                                    imagePath: ImageConstant.iconClose,
                                    //height: 30.hw,
                                    //width: 30.hw,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                               /* CustomImageView(
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
                                ), */
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
