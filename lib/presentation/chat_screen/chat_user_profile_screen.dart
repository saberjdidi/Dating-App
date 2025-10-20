import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/controller/profile_details_controller.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/fullscreen_image_viewer.dart';
import 'package:dating_app_bilhalal/widgets/chat/user_stats_widget.dart';
import 'package:dating_app_bilhalal/widgets/grid_layout.dart';
import 'package:dating_app_bilhalal/widgets/home/tabbed_page_widget.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/swip_back_wrapper.dart';
import 'package:flutter/material.dart';

class ChatUserProfileScreen extends GetView<ProfileDetailsController> {
   ChatUserProfileScreen({super.key});

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
                         imagePath: ImageConstant.profile8,
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
                       child: IconButton(
                         icon: Icon(Icons.arrow_forward_outlined, color: TColors.white, size: 35.hw,),
                         onPressed: (){
                           Navigator.pop(context);
                         },
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
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisSize: MainAxisSize.min,
                 children: [
                   SubTitleWidget(fontSizeDelta: 3, fontWeightDelta: 2,subtitle: 'نورا خالد', color: _appTheme =='light' ? TColors.black : TColors.white),
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
                           fontSize: isTablet ? 16.adaptSize : 15.adaptSize,
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
                           fontSize: isTablet ? 16.adaptSize : 15.adaptSize,
                         ),
                       ),
                     ],
                   ),
                   SizedBox(width: 10.v),
                   UserStatsWidget(
                     height: "172 cm",
                     weight: "60 kg",
                     salary: "110K - 600K",
                     skinColor: "deep",
                     iconSize: 30,
                   ),

                   SizedBox(height: TSizes.spaceBtwSections.v),
                   SubTitleWidget(subtitle: "الوسائط المشتركة", color: _appTheme =='light' ? TColors.black : TColors.white, fontWeightDelta: 2, fontSizeDelta: 3),
                   SizedBox(width: 10.v),
                   TabbedPageWidget(
                     tabs: [
                       TabItem("الکل"),
                       TabItem("صور"),
                       TabItem("أشرطة الفيديو"),
                     ],
                     onTabChanged: controller.onTabChanged,
                     activeColor: TColors.primaryColorApp,
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
                               images: controller.ListImages.value,
                               initialIndex: index,
                             ));
                           },
                         ),
                       );
                     },
                   ),

                   SizedBox(height: TSizes.spaceBtwSections.v),

                 ],
               ),
             )
         )
     );
   }
}