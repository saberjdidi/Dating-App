import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/interest_model.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/controller/profile_details_controller.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/fullscreen_image_viewer.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/fullscreen_media_viewer.dart';
import 'package:dating_app_bilhalal/widgets/account/interest_widget.dart';
import 'package:dating_app_bilhalal/widgets/chat/user_stats_widget.dart';
import 'package:dating_app_bilhalal/widgets/circle_icon_button.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
import 'package:dating_app_bilhalal/widgets/favourite/favorite_icon.dart';
import 'package:dating_app_bilhalal/widgets/grid_layout.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/swip_back_wrapper.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:dating_app_bilhalal/widgets/video_preview_gallery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:readmore/readmore.dart';

class ProfileDetailsScreen extends GetView<ProfileDetailsController> {
   ProfileDetailsScreen({super.key});

   var isArabe = PrefUtils.getLangue() == 'ar';
   var isLight = PrefUtils.getTheme() == "light";

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
            //backgroundColor: PrefUtils().getThemeData() =='light' ? TColors.lightContainer : TColors.darkerGrey,
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
                      imagePath: (controller.mainProfile == "" || controller.mainProfile.isEmpty || controller.mainProfile == null)
                          ? ImageConstant.imgOnBoarding1
                          : controller.mainProfile,
                      //height: 200.adaptSize,
                      //width: 200.adaptSize,
                      fit: BoxFit.cover,
                    ),
                  ),

                  // Image en haut à gauche
                  Positioned(
                    top: 20,
                    left: 20,
                   child: IconButton(
                     icon: Icon(Icons.more_vert, color: TColors.white, size: 35.hw,),
                     onPressed: () async {
                      await Dialogs.buildDialogSettings(context, controller);
                     },
                   ),
                   /* child:  CircleIconButton(
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
                    ) */
                  ),

                  // Image en haut à droite
                  Positioned(
                    top: 20,
                    right: 20,
                   child:  Directionality(
                     textDirection: TextDirection.ltr,
                     child: IconButton(
                       icon: Icon(Icons.arrow_forward_outlined, color: TColors.white, size: 35.hw,),
                       onPressed: (){
                         Navigator.pop(context);
                       },
                     ),
                   ),
                   /* child: CircleIconButton(
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
                    ) */
                  ),


                  /// ✅ Conteneur animé avec GetX
                  Obx(() => AnimatedPositioned(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    bottom: controller.showUserInfo.value ? 0 : -screenHeight * 0.6,
                    left: 0,
                    right: 0,
                      child: _buildUserInfo2(context)
                    //child: _buildUserInfo(context)
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
         backgroundColor: isLight ? TColors.white : TColors.dark,
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
                   //Text(controller.userModel.id ?? '', style: TextStyle(color: isLight ? TColors.black : TColors.white),),
                   if(controller.userModel.username != null && controller.userModel.age != null)
                     SubTitleWidget(fontSizeDelta: 2, fontWeightDelta: 2,subtitle: '${controller.userModel.username}، ${controller.userModel.age} عاما',
                         color: isLight ? TColors.black : TColors.white),
                   SizedBox(height: 6.v),
                   // job - allow up to 2 lines then ellipsis
                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       CustomImageView(
                         imagePath: ImageConstant.iconJob,
                         color: isLight ? TColors.darkerGrey : TColors.white,
                         //height: 200.adaptSize,
                         //width: 200.adaptSize,
                         fit: BoxFit.cover,
                       ),
                       SizedBox(width: 10.adaptSize),
                       if((controller.userModel.jobTitle ?? '').isNotEmpty)
                       Expanded(
                         child: Text(
                           controller.userModel.jobTitle ?? '',
                           textAlign: TextAlign.right,
                           maxLines: 4,
                           overflow: TextOverflow.ellipsis,
                           style: TextStyle(
                             color: isLight ? TColors.darkerGrey : TColors.white,
                             fontSize: isTablet ? 16.adaptSize : 15.adaptSize,
                           ),
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
                         color: isLight ? TColors.darkerGrey : TColors.white,
                         //height: 200.adaptSize,
                         //width: 200.adaptSize,
                         fit: BoxFit.cover,
                       ),
                       SizedBox(width: 10.adaptSize),
                       if((controller.userModel.profile!.country ?? '').isNotEmpty)
                         Text(controller.userModel.profile!.country ?? '',
                           textAlign: TextAlign.right,
                           maxLines: 2,
                           overflow: TextOverflow.ellipsis,
                           style: TextStyle(
                             color: isLight ? TColors.darkerGrey : TColors.white,
                             fontSize: isTablet ? 16.adaptSize : 15.adaptSize,
                           ),
                         ),
                     ],
                   ),

                   SizedBox(height: TSizes.spaceBtwItems.v),
                   UserStatsWidget(
                     height: (controller.userModel.height != null || controller.userModel.height! > 0) ? '${controller.userModel.height} ${'lbl_cm'.tr} '  : '',
                     weight: (controller.userModel.weight != null || controller.userModel.weight! > 0) ? ' ${controller.userModel.weight} ${'lbl_kg'.tr} '  : '',
                     salary: "110K - 600K",
                     skinColor: controller.userModel.profile!.skinToneHex != null || controller.userModel.profile!.skinToneHex!.isNotEmpty ? controller.userModel.profile!.skinToneHex! : "#e0cda9",
                     iconSize: 30,
                   ),

                   SizedBox(height: 10.v),
                   SubTitleWidget(subtitle: "بایو:", color: isLight ? TColors.black : TColors.white, fontWeightDelta: 2, fontSizeDelta: 3,),
                   if((controller.userModel.description ?? '').isNotEmpty)
                   ReadMoreText(controller.userModel.description ?? '',
                     trimMode: TrimMode.Line,
                     trimLines: 3,
                     trimLength: 240,
                     //preDataText: 'avant de text',
                     //preDataTextStyle: const TextStyle(fontWeight: FontWeight.w500),
                     style: TextStyle(fontSize: 15.adaptSize, color:  isLight ? TColors.black : TColors.white),
                     //style: Theme.of(context).textTheme.bodyMedium!.apply(color: isLight ? TColors.black : TColors.white, fontSizeDelta: 1, fontWeightDelta: 1),
                     colorClickableText: Colors.blue,
                     trimCollapsedText: 'اقرأ المزيد',
                     trimExpandedText: ' إظهار أقل',
                     moreStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                     lessStyle:  TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                   ),
                   // SubTitleWidget(subtitle: "اسمي جيسيكا باركر، وأستمتع بلقاء أشخاص جدد وإيجاد طرق لمساعدتهم على خوض تجربة إيجابية. أستمتع بالقراءة....اقرأ المزيد", color: isLight ? TColors.black : TColors.white, textAlign: TextAlign.right,),

                   SizedBox(height: 20.v),
                   if (controller.userModel.hobbies != null &&
                       controller.userModel.hobbies!.isNotEmpty) ...[
                     SizedBox(height: 20.v),
                     SubTitleWidget(
                       subtitle: "الاهتمامات",
                       color: isLight ? TColors.black : TColors.white,
                       fontWeightDelta: 2,
                       fontSizeDelta: 3,
                     ),
                     Wrap(
                       spacing: 8, // Espace horizontal entre les items
                       runSpacing: 8, // Espace vertical entre les lignes
                       alignment: WrapAlignment.start,
                       children: controller.userModel.hobbies!.map((interestName) {
                         return InterestWidget(
                           text: isArabe ? THelperFunctions.getInterestArabic(interestName) : interestName,
                           iconPath: isArabe
                               ? InterestModel.getIconByName(THelperFunctions.getInterestArabic(interestName))
                               : InterestModel.getIconByName(interestName),
                           //iconPath: InterestModel.getIconByName(interestName),
                           isSelected: true,
                           activeColor: true,
                           showRandomColor: true,
                           randomList: THelperFunctions.randomColorList,
                           onTap: () {},
                         );
                       }).toList(),
                     ),
                   ],
                   SizedBox(height: 20.v),

                 if (controller.mediaList != null &&
                 controller.mediaList.isNotEmpty) ...[
                   SubTitleWidget(subtitle: "معرض", color: isLight ? TColors.black : TColors.white, fontWeightDelta: 4, fontSizeDelta: 5,),
                   SizedBox(height: 5.v),

                   ///Dynamic Gallery
                   Obx(() {
                     if (controller.isMediaProcessing.value) {
                       return const Center(child: CircularProgressIndicator(color: TColors.primaryColorApp,));
                     }

                     if (controller.mediaList.isEmpty) {
                       return const Center(child: Text('لا توجد بيانات بعد'));
                     }

                     return GridLayout(
                       itemCount: controller.mediaList.length, // +1 pour l'upload
                       mainAxisExtent: isTablet ? 220.adaptSize : 180.adaptSize,
                       crossAxisCount: 3,
                       itemBuilder: (context, index) {
                         final media = controller.mediaList[index];
                         final isVideo = media.mediaType == 'video';
                         return TRoundedContainer(
                           showBorder: true,
                           backgroundColor: TColors.white,
                           borderColor: TColors.greyDating,
                           radius: 12,
                           padding: EdgeInsets.all(1),
                           child: GestureDetector(
                             onTap:  (){
                               Get.to(() => FullScreenMediaViewer(
                                 medias: controller.mediaList,
                                 initialIndex: index,
                               ));
                             },
                             child: isVideo
                                 ? ClipRRect(
                               borderRadius: BorderRadius.circular(10),
                               child: VideoPreviewGallery(
                                 url: media.mediaUrl,
                               ),
                             )
                                 :CustomImageView(
                               imagePath: media.mediaUrl,
                               height: Get.height,
                               width: Get.width,
                               fit: BoxFit.cover,
                               radius: BorderRadius.circular(10),
                             ),
                           ),
                         );
                       },
                     );
                   }),
                 ],
                   ///Static Gallery
                  /* GridLayout(
                     itemCount: controller.ListImages.value.length, // +1 pour l'upload
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
                         child:
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
                       );
                     },
                   ), */

                   SizedBox(height: TSizes.spaceBtwSections.v),
                   Row(
                     crossAxisAlignment: CrossAxisAlignment.center,
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       CircleIconButton(
                         size: isSmallPhone ?  50.hw : 40.hw,
                         minTapSize: isSmallPhone ?  50.hw : 40.hw,
                         effectiveSize: isSmallPhone ?  50.hw : 40.hw,
                         backgroundColor: isLight ? TColors.greyDating.withOpacity(0.5) : TColors.dark,
                         showBorder: true,
                         borderColor: isLight ? TColors.white : TColors.buttonSecondary,
                         // child: FavoriteIcon(userId: controller.userModel.id ?? ''),
                         child: CustomImageView(
                           imagePath: ImageConstant.likeImg,
                           height: 30.adaptSize,
                           width: 30.adaptSize,
                           color: TColors.redApp,
                         ),
                       ),
                       CircleIconButton(
                         size: isSmallPhone ? 70.hw : 50.hw,
                         minTapSize: isSmallPhone ? 70.hw : 50.hw,
                         effectiveSize: isSmallPhone ? 70.hw : 50.hw,
                         backgroundColor: isLight ? TColors.greyDating.withOpacity(0.5) : TColors.dark,
                         showBorder: true,
                         borderColor: isLight ? TColors.white : TColors.buttonSecondary,
                         //borderColor: TColors.primaryColorApp,
                         //backgroundColor: TColors.greyDating.withOpacity(0.5),
                         child: CustomImageView(
                           imagePath: ImageConstant.iconChat,
                           color: TColors.primaryColorApp,
                           height: 30.hw,
                           width: 30.hw,
                           //fit: BoxFit.cover,
                         ),
                       ),
                       CircleIconButton(
                         size: isSmallPhone ? 50.hw : 40.hw,
                         minTapSize: isSmallPhone ?  50.hw : 40.hw,
                         effectiveSize: isSmallPhone ?  50.hw : 40.hw,
                         backgroundColor: isLight ? TColors.greyDating.withOpacity(0.5) : TColors.dark,
                         showBorder: true,
                         borderColor: isLight ? TColors.white : TColors.buttonSecondary,
                         child: CustomImageView(
                           imagePath: ImageConstant.iconClose,
                           height: 30.hw,
                           width: 30.hw,
                           //fit: BoxFit.cover,
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
     );
   }

   Widget _buildUserInfo2(BuildContext context) {

     mediaQueryData = MediaQuery.of(context);
     var screenWidth = mediaQueryData.size.width;
     var screenHeight = mediaQueryData.size.height;
     var isSmallPhone = screenWidth < 360;
     var isTablet = screenWidth >= 600;
     return TRoundedContainer(
         backgroundColor: isLight ? TColors.white : TColors.dark,
         width: double.infinity,
         height: screenHeight * 0.6,
         radius: 50.adaptSize,
         isBorderRadiusTop: true,
         padding: EdgeInsets.symmetric(
           horizontal: TSizes.spaceBtwSections.hw,
           vertical: TSizes.spaceBtwItems.v,
         ),
         child: Obx(() {
           if (controller.isDataProcessing.value) {
             return const Center(child: CircularProgressIndicator(color: TColors.primaryColorApp,));
           }

           // ✅ Vérifie si user est null avant d'y accéder
           if (controller.user.value == null) {
             return Center(child: Text(controller.message.value,
               style: TextStyle(color:  isLight ? TColors.black : TColors.white,
                   fontSize: 18.adaptSize, fontWeight: FontWeight.w500),));
           }

           final user = controller.user.value!;

           return Directionality(
               textDirection: TextDirection.rtl,
               child: SingleChildScrollView(
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisSize: MainAxisSize.min,
                   children: [
                     //Text(controller.userModel.id ?? '', style: TextStyle(color: isLight ? TColors.black : TColors.white),),
                     if(user.username != null && user.age != null)
                       SubTitleWidget(fontSizeDelta: 2, fontWeightDelta: 2,subtitle: '${user.username}، ${user.age} عاما',
                           color: isLight ? TColors.black : TColors.white),
                     SizedBox(height: 6.v),
                     // job - allow up to 2 lines then ellipsis
                     Row(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         CustomImageView(
                           imagePath: ImageConstant.iconJob,
                           color: isLight ? TColors.darkerGrey : TColors.white,
                           //height: 200.adaptSize,
                           //width: 200.adaptSize,
                           fit: BoxFit.cover,
                         ),
                         SizedBox(width: 10.adaptSize),
                         if((user.jobTitle ?? '').isNotEmpty)
                           Expanded(
                             child: Text(
                               user.jobTitle ?? '',
                               textAlign: TextAlign.right,
                               maxLines: 4,
                               overflow: TextOverflow.ellipsis,
                               style: TextStyle(
                                 color: isLight ? TColors.darkerGrey : TColors.white,
                                 fontSize: isTablet ? 16.adaptSize : 15.adaptSize,
                               ),
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
                           color: isLight ? TColors.darkerGrey : TColors.white,
                           //height: 200.adaptSize,
                           //width: 200.adaptSize,
                           fit: BoxFit.cover,
                         ),
                         SizedBox(width: 10.adaptSize),
                         if((user.profile!.country ?? '').isNotEmpty)
                           Text(user.profile!.country ?? '',
                             textAlign: TextAlign.right,
                             maxLines: 2,
                             overflow: TextOverflow.ellipsis,
                             style: TextStyle(
                               color: isLight ? TColors.darkerGrey : TColors.white,
                               fontSize: isTablet ? 16.adaptSize : 15.adaptSize,
                             ),
                           ),
                       ],
                     ),

                     SizedBox(height: TSizes.spaceBtwItems.v),
                     UserStatsWidget(
                       height: (user.height != null || user.height! > 0) ? '${user.height} ${'lbl_cm'.tr} '  : '',
                       weight: (user.weight != null || user.weight! > 0) ? ' ${user.weight} ${'lbl_kg'.tr} '  : '',
                       salary: "110K - 600K",
                       skinColor: (user.profile!.skinToneHex != null || user.profile!.skinToneHex!.isNotEmpty) ? user.profile!.skinToneHex! : "#e0cda9",
                       iconSize: 30,
                     ),

                     SizedBox(height: 10.v),
                     SubTitleWidget(subtitle: "بایو:", color: isLight ? TColors.black : TColors.white, fontWeightDelta: 2, fontSizeDelta: 3,),
                     if((user.description ?? '').isNotEmpty)
                       ReadMoreText(user.description ?? '',
                         trimMode: TrimMode.Line,
                         trimLines: 3,
                         trimLength: 240,
                         //preDataText: 'avant de text',
                         //preDataTextStyle: const TextStyle(fontWeight: FontWeight.w500),
                         style: TextStyle(fontSize: 15.adaptSize, color:  isLight ? TColors.black : TColors.white),
                         //style: Theme.of(context).textTheme.bodyMedium!.apply(color: isLight ? TColors.black : TColors.white, fontSizeDelta: 1, fontWeightDelta: 1),
                         colorClickableText: Colors.blue,
                         trimCollapsedText: 'اقرأ المزيد',
                         trimExpandedText: ' إظهار أقل',
                         moreStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                         lessStyle:  TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                       ),
                     // SubTitleWidget(subtitle: "اسمي جيسيكا باركر، وأستمتع بلقاء أشخاص جدد وإيجاد طرق لمساعدتهم على خوض تجربة إيجابية. أستمتع بالقراءة....اقرأ المزيد", color: isLight ? TColors.black : TColors.white, textAlign: TextAlign.right,),

                     SizedBox(height: 20.v),
                     if (user.hobbies != null &&
                         user.hobbies!.isNotEmpty) ...[
                       SizedBox(height: 20.v),
                       SubTitleWidget(
                         subtitle: "الاهتمامات",
                         color: isLight ? TColors.black : TColors.white,
                         fontWeightDelta: 2,
                         fontSizeDelta: 3,
                       ),
                       Wrap(
                         spacing: 8, // Espace horizontal entre les items
                         runSpacing: 8, // Espace vertical entre les lignes
                         alignment: WrapAlignment.start,
                         children: controller.userModel.hobbies!.map((interestName) {
                           return InterestWidget(
                             text: isArabe ? THelperFunctions.getInterestArabic(interestName) : interestName,
                             iconPath: isArabe
                                 ? InterestModel.getIconByName(THelperFunctions.getInterestArabic(interestName))
                                 : InterestModel.getIconByName(interestName),
                             //iconPath: InterestModel.getIconByName(interestName),
                             isSelected: true,
                             activeColor: true,
                             showRandomColor: true,
                             randomList: THelperFunctions.randomColorList,
                             onTap: () {},
                           );
                         }).toList(),
                       ),
                     ],
                     SizedBox(height: 20.v),

                     if (controller.mediaList != null &&
                         controller.mediaList.isNotEmpty) ...[
                       SubTitleWidget(subtitle: "معرض", color: isLight ? TColors.black : TColors.white, fontWeightDelta: 4, fontSizeDelta: 5,),
                       SizedBox(height: 5.v),

                       ///Dynamic Gallery
                     if (controller.isMediaProcessing.value)
                      Center(child: CircularProgressIndicator(color: TColors.primaryColorApp,)),

                     if (controller.mediaList.isEmpty)
                     Center(child: Text('لا توجد بيانات بعد')),

                       GridLayout(
                         itemCount: controller.mediaList.length, // +1 pour l'upload
                         mainAxisExtent: isTablet ? 220.adaptSize : 180.adaptSize,
                         crossAxisCount: 3,
                         itemBuilder: (context, index) {
                           final media = controller.mediaList[index];
                           final isVideo = media.mediaType == 'video';
                           return TRoundedContainer(
                             showBorder: true,
                             backgroundColor: TColors.white,
                             borderColor: TColors.greyDating,
                             radius: 12,
                             padding: EdgeInsets.all(1),
                             child: GestureDetector(
                               onTap:  (){
                                 Get.to(() => FullScreenMediaViewer(
                                   medias: controller.mediaList,
                                   initialIndex: index,
                                 ));
                               },
                               child: isVideo
                                   ? ClipRRect(
                                 borderRadius: BorderRadius.circular(10),
                                 child: VideoPreviewGallery(
                                   url: media.mediaUrl,
                                 ),
                               )
                                   :CustomImageView(
                                 imagePath: media.mediaUrl,
                                 height: Get.height,
                                 width: Get.width,
                                 fit: BoxFit.cover,
                                 radius: BorderRadius.circular(10),
                               ),
                             ),
                           );
                         },
                       )
                     ],
                     ///Static Gallery
                     /* GridLayout(
                     itemCount: controller.ListImages.value.length, // +1 pour l'upload
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
                         child:
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
                       );
                     },
                   ), */

                     SizedBox(height: TSizes.spaceBtwSections.v),
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         CircleIconButton(
                           size: isSmallPhone ?  50.hw : 40.hw,
                           minTapSize: isSmallPhone ?  50.hw : 40.hw,
                           effectiveSize: isSmallPhone ?  50.hw : 40.hw,
                           backgroundColor: isLight ? TColors.greyDating.withOpacity(0.5) : TColors.dark,
                           showBorder: true,
                           borderColor: isLight ? TColors.white : TColors.buttonSecondary,
                           // child: FavoriteIcon(userId: controller.userModel.id ?? ''),
                           child: CustomImageView(
                             imagePath: ImageConstant.likeImg,
                             height: 30.adaptSize,
                             width: 30.adaptSize,
                             color: TColors.redApp,
                           ),
                         ),
                         CircleIconButton(
                           size: isSmallPhone ? 70.hw : 50.hw,
                           minTapSize: isSmallPhone ? 70.hw : 50.hw,
                           effectiveSize: isSmallPhone ? 70.hw : 50.hw,
                           backgroundColor: isLight ? TColors.greyDating.withOpacity(0.5) : TColors.dark,
                           showBorder: true,
                           borderColor: isLight ? TColors.white : TColors.buttonSecondary,
                           //borderColor: TColors.primaryColorApp,
                           //backgroundColor: TColors.greyDating.withOpacity(0.5),
                           child: CustomImageView(
                             imagePath: ImageConstant.iconChat,
                             color: TColors.primaryColorApp,
                             height: 30.hw,
                             width: 30.hw,
                             //fit: BoxFit.cover,
                           ),
                         ),
                         CircleIconButton(
                           size: isSmallPhone ? 50.hw : 40.hw,
                           minTapSize: isSmallPhone ?  50.hw : 40.hw,
                           effectiveSize: isSmallPhone ?  50.hw : 40.hw,
                           backgroundColor: isLight ? TColors.greyDating.withOpacity(0.5) : TColors.dark,
                           showBorder: true,
                           borderColor: isLight ? TColors.white : TColors.buttonSecondary,
                           child: CustomImageView(
                             imagePath: ImageConstant.iconClose,
                             height: 30.hw,
                             width: 30.hw,
                             //fit: BoxFit.cover,
                           ),
                         ),
                       ],
                     )
                   ],
                 ),
               )
           );
         })
     );
   }

}
