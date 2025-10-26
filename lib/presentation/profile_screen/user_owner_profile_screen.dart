import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/interest_model.dart';
import 'package:dating_app_bilhalal/data/models/media_model.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/controller/user_owner_profile_controller.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/fullscreen_image_viewer.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/fullscreen_media_viewer.dart';
import 'package:dating_app_bilhalal/widgets/account/interest_widget.dart';
import 'package:dating_app_bilhalal/widgets/chat/user_stats_widget.dart';
import 'package:dating_app_bilhalal/widgets/circle_icon_button.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
import 'package:dating_app_bilhalal/widgets/grid_layout.dart';
import 'package:dating_app_bilhalal/widgets/home/tabbed_page_widget.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/swip_back_wrapper.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:dating_app_bilhalal/widgets/video_preview_gallery.dart';
import 'package:flutter/material.dart';

class UserOwnerProfileScreen extends GetView<UserOwnerProfileController> {
   UserOwnerProfileScreen({super.key});

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
        child: SwipeBackWrapper(
          child: Scaffold(
            //backgroundColor: PrefUtils.getTheme() =='light' ? TColors.lightContainer : TColors.darkerGrey,
              resizeToAvoidBottomInset: false,

              body: GestureDetector(
                // ✅ Tape sur l’image → inverse l’état
                onTap: controller.toggleUserInfo,

                // ✅ Glissement vertical pour montrer/cacher
                onVerticalDragUpdate: (details) {
                  if (details.primaryDelta != null && details.primaryDelta! > 10) {
                    // 🔽 swipe down → cache
                    controller.hideUserInfo();
                  } else if (details.primaryDelta != null && details.primaryDelta! < -10) {
                    // 🔼 swipe up → affiche
                    controller.showInfo();
                  }
                },
                child: Stack(
                  children: [
                    // background image (fills)
                    Positioned.fill(
                      child: CustomImageView(
                        imagePath: (PrefUtils.getImageProfile() != null && PrefUtils.getImageProfile()!.isNotEmpty)
                            ? PrefUtils.getImageProfile()
                            : ImageConstant.profile8,
                        //imagePath: ImageConstant.profile8,
                        //height: 200.adaptSize,
                        //width: 200.adaptSize,
                        fit: BoxFit.cover,
                      ),
                    ),

                    // Image en haut à droite
                    Positioned(
                      top: 20,
                      right: 20,
                      child:  Directionality(
                        textDirection: TextDirection.ltr,
                        child: IconButton(
                          icon: Icon(Icons.arrow_forward_outlined, color: TColors.white, size: 35.hw),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),
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
                    /// ✅ Conteneur animé avec GetX
                    Obx(() => AnimatedPositioned(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        bottom: controller.showUserInfo.value ? 0 : -screenHeight * 0.6,
                        left: 0,
                        right: 0,
                        child: _buildUserInfo(context)
                    )),
                  ],
                ),
              )
          ),
        )
    );
  }

   Widget _buildUserInfo(BuildContext context) {

     mediaQueryData = MediaQuery.of(context);
     var screenWidth = mediaQueryData.size.width;
     var screenHeight = mediaQueryData.size.height;
     var isSmallPhone = screenWidth < 360;
     var isTablet = screenWidth >= 600;
     return TRoundedContainer(
         backgroundColor: _appTheme =='light' ? TColors.white : TColors.dark,
         width: double.infinity,
         height: screenHeight * 0.6,
         radius: 50.adaptSize,
         isBorderRadiusTop: true,
         padding: EdgeInsets.symmetric(
           horizontal: TSizes.spaceBtwItems.hw,
           vertical: TSizes.spaceBtwItems.v,
         ),
         child: Directionality(
             textDirection: TextDirection.rtl,
             child: SingleChildScrollView(
               child: Obx((){
                 if (controller.isDataProcessing.value) {
                   return const Center(child: CircularProgressIndicator(color: TColors.primaryColorApp,));
                 }

                 //final images = controller.mediaList.where((m) => m.mediaType == 'image').map((m) => m.mediaUrl).toList();

                 // 🔹 Sélection du contenu selon l’onglet actif
                 final tabIndex = controller.selectedTab.value; // à ajouter dans ton controller si pas encore
                 List<MediaModel> filteredMedia;

                 if (tabIndex == 1) {
                   filteredMedia = controller.mediaList
                       .where((m) => m.mediaType == 'image')
                       .toList();
                 } else if (tabIndex == 2) {
                   filteredMedia = controller.mediaList
                       .where((m) => m.mediaType == 'video')
                       .toList();
                 } else {
                   filteredMedia = controller.mediaList; // tous
                 }

                 if (filteredMedia.isEmpty) {
                   return const Center(child: Text('لا توجد بيانات بعد'));
                 }

                 // ✅ Vérifie si user est null avant d'y accéder
                 if (controller.user.value == null) {
                   return Center(child: Text("جارٍ تحميل الملف الشخصي...",
                     style: TextStyle(color:  _appTheme =='light' ? TColors.black : TColors.white,
                         fontSize: 18.adaptSize, fontWeight: FontWeight.w500),));
                 }

                 final user = controller.user.value!;

                 return Column(
                   crossAxisAlignment: CrossAxisAlignment.center,
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text(''),
                         if((user.username ?? '').isNotEmpty)
                           SubTitleWidget(subtitle: user.username ?? '', //subtitle: 'نورا خالد',
                             fontSizeDelta: 3, fontWeightDelta: 2,
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
                         if((user.profile!.jobTitle ?? '').isNotEmpty)
                           Flexible(
                             child: Text(user.profile!.jobTitle ?? '',//"نموذج احترافي",
                               textAlign: TextAlign.right,
                               maxLines: 3,
                               overflow: TextOverflow.ellipsis,
                               style: TextStyle(
                                 color: _appTheme =='light' ? TColors.darkerGrey : TColors.white,
                                 fontSize: isTablet ? 16.adaptSize : 15.adaptSize,
                               ),
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
                         if((user.profile!.country ?? '').isNotEmpty)
                           Text(user.profile!.country ?? '' , //"المملكة العربية السعودية",
                             textAlign: TextAlign.right,
                             maxLines: 2,
                             overflow: TextOverflow.ellipsis,
                             style: TextStyle(
                               color: _appTheme =='light' ? TColors.darkerGrey : TColors.white,
                               fontSize: isTablet ? 16.adaptSize : 15.adaptSize,
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
                       fontSize: isTablet ? 25.adaptSize : 21.adaptSize,
                       height: isSmallPhone ? 75.v : 65.v,
                       width: isTablet ? Get.width * 0.5 : Get.width * 0.6,
                       onPressed: () async {
                         Get.toNamed(Routes.editProfileScreen, arguments: {
                           "UserInfo" : controller.user.value!
                         });
                       },
                     ),
                     SizedBox(height: TSizes.spaceBtwItems.v),
                     UserStatsWidget(
                       height: "${controller.user.value!.height} cm",
                       weight: "${controller.user.value!.weight} kg",
                       salary: "${controller.user.value!.profile!.salaryRangeMin}K - ${controller.user.value!.profile!.salaryRangeMax}K",
                       skinColor: "${controller.user.value!.profile!.skinToneHex!.toLowerCase()}",//"skinColor3",
                       iconSize: 30,
                     ),

                     SizedBox(height: TSizes.spaceBtwSections.v),
                     //if(controller.hobbiesList.isEmpty)
                       Wrap(
                         spacing: 5,
                         runSpacing: 5,
                         children: controller.hobbiesList.map((interest) {
                           return InterestWidget(
                             text: THelperFunctions.getInterestArabic(interest.name!),
                             //text: interest.name!,
                             iconPath: InterestModel.getIconByName(THelperFunctions.getInterestArabic(interest.name!)),
                             //iconPath: InterestModel.getIconByName(interest.name!),
                             //iconPath: interest.icon!,
                             isSelected: true,
                             activeColor: true,
                             verticalPadding: 13.v,
                             showRandomColor: true, // ✅ afficher la couleur seulement si sélectionné
                             randomList: THelperFunctions.randomColorList,
                             onTap: () {  },
                           );
                         }).toList(),
                       ),

                     SizedBox(height: TSizes.spaceBtwSections.v),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         SubTitleWidget(fontSizeDelta: 2, fontWeightDelta: 2,subtitle: "الصور / الفيديوات", color: _appTheme =='light' ? TColors.black : TColors.white),
                         CustomButtonContainer(
                             text:"تعديل",
                             color1: TColors.primaryColorApp,
                             color2: TColors.primaryColorApp,
                             borderRadius: 30,
                             colorText: TColors.white,
                             fontSize: isTablet ? 25.adaptSize : 21.adaptSize,
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
                     if (filteredMedia.isEmpty)
                       Center(child: Text('لا توجد بيانات بعد')),

                     RefreshIndicator(
                       onRefresh: controller.getAllMedia,
                       child: GridLayout(
                         itemCount: filteredMedia.length,
                         mainAxisExtent: isTablet ? 220.adaptSize : 180.adaptSize,
                         crossAxisCount: 3,
                         itemBuilder: (context, index) {
                           final media = filteredMedia[index];
                           final isVideo = media.mediaType == 'video';
                           return TRoundedContainer(
                             showBorder: true,
                             backgroundColor: TColors.white,
                             borderColor: TColors.greyDating,
                             radius: 12,
                             padding: EdgeInsets.all(1),
                             child: Stack(
                               children: [
                                 // ✅ Image
                                 if (!isVideo)
                                   CustomImageView(
                                     imagePath: media.mediaUrl,
                                     height: Get.height,
                                     width: Get.width,
                                     fit: BoxFit.cover,
                                     radius: BorderRadius.circular(10),
                                     onTap: () {
                                       Get.to(() => FullScreenMediaViewer(
                                         medias: controller.mediaList,
                                         initialIndex: index,
                                       ));
                                     },
                                   ),
                                 // ✅ Vidéo
                                 if (isVideo)
                                   GestureDetector(
                                     onTap: () {
                                       Get.to(() => FullScreenMediaViewer(
                                         medias: controller.mediaList,
                                         initialIndex: index,
                                       ));
                                     },
                                     onDoubleTap: () {
                                       Get.to(() => FullScreenMediaViewer(
                                         medias: controller.mediaList,
                                         initialIndex: index,
                                       ));
                                     },
                                     child: ClipRRect(
                                       borderRadius: BorderRadius.circular(10),
                                       child: VideoPreviewGallery(
                                         url: media.mediaUrl,
                                       ),
                                     ),
                                   ),
                                 // ❤️ Bouton favoris + compteur
                                 // ✅ Affiche seulement si favouriteCount > 0
                                 if (media.favouriteCount > 0) ...[
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
                                           Text(' إعجابًا${media.favouriteCount}', style: TextStyle(color: TColors.white, fontSize: 15.adaptSize, fontWeight: FontWeight.w500)),
                                         ],
                                       )
                                   ),
                                 ]

                               ],
                             ),
                           );
                         },
                       ),
                     ),

                     /* Obx(() {
                                        if (controller.isDataProcessing.value) {
                                          return const Center(child: CircularProgressIndicator());
                                        }

                                        //final images = controller.mediaList.where((m) => m.mediaType == 'image').map((m) => m.mediaUrl).toList();

                                        // 🔹 Sélection du contenu selon l’onglet actif
                                        final tabIndex = controller.selectedTab.value; // à ajouter dans ton controller si pas encore
                                        List<MediaModel> filteredMedia;

                                        if (tabIndex == 1) {

                                          filteredMedia = controller.mediaList
                                              .where((m) => m.mediaType == 'image')
                                              .toList();
                                        } else if (tabIndex == 2) {
                                          filteredMedia = controller.mediaList
                                              .where((m) => m.mediaType == 'video')
                                              .toList();
                                        } else {
                                          filteredMedia = controller.mediaList; // tous
                                        }

                                        if (filteredMedia.isEmpty) {
                                          return const Center(child: Text('لا توجد بيانات بعد'));
                                        }

                                        return GridLayout(
                                          itemCount: filteredMedia.length,
                                          mainAxisExtent: isTablet ? 220.adaptSize : 180.adaptSize,
                                          crossAxisCount: 3,
                                          itemBuilder: (context, index) {
                                            final media = filteredMedia[index];
                                            return TRoundedContainer(
                                              showBorder: true,
                                              backgroundColor: TColors.white,
                                              borderColor: TColors.greyDating,
                                              radius: 12,
                                              padding: EdgeInsets.all(1),
                                              child: Stack(
                                                children: [
                                                  CustomImageView(
                                                    imagePath: media.mediaUrl,
                                                    height: Get.height,
                                                    width: Get.width,
                                                    fit: BoxFit.cover,
                                                    radius: BorderRadius.circular(10),
                                                    onTap: () {
                                                      Get.to(() => FullScreenImageViewer(
                                                        images: filteredMedia
                                                            .where((m) => m.mediaType == 'image')
                                                            .map((m) => m.mediaUrl)
                                                            .toList(),
                                                        initialIndex: index,
                                                      ));
                                                    },
                                                  ),
                                                  // ❤️ Bouton favoris + compteur
                                                  // ✅ Affiche seulement si favouriteCount > 0
                                                  if (media.favouriteCount > 0) ...[
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
                                                            Text(' إعجابًا${media.favouriteCount}', style: TextStyle(color: TColors.white, fontSize: 15.adaptSize, fontWeight: FontWeight.w500)),
                                                          ],
                                                        )
                                                    ),
                                                  ]

                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      }), */
                     //Static Media
                     /*
                                      Visibility(
                                        visible: false,
                                        child: GridLayout(
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
                                                          Text('23 إعجابًا', style: TextStyle(color: TColors.white, fontSize: 15.adaptSize, fontWeight: FontWeight.w500)),
                                                          //SubTitleWidget(subtitle: '23 إعجابًا', color: TColors.white, fontWeightDelta: 2),
                                                        ],
                                                      )
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      */

                     SizedBox(height: TSizes.spaceBtwSections.v),

                   ],
                 );
               }),
             )
         )
     );
   }
}