
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/controller/media_owner_profile_controller.dart';
import 'package:dating_app_bilhalal/widgets/app_bar/appbar_widget.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
import 'package:dating_app_bilhalal/widgets/grid_layout.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:dating_app_bilhalal/widgets/video_preview_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MediaOwnerProfileScreen extends GetWidget<MediaOwnerProfileController> {
   MediaOwnerProfileScreen({super.key});

   final GlobalKey<ScaffoldState> _scaffoldKeyMediaProfile = GlobalKey<ScaffoldState>();
  var _appTheme = PrefUtils().getThemeData();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return SafeArea(
        child: Form(
        key: controller.formMediaProfileKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Scaffold(
          key: _scaffoldKeyMediaProfile,
        backgroundColor: _appTheme =='light' ? TColors.white : appTheme.primaryColor,
        appBar: TAppBar(
          title: TitleWidget(title: "تعديل الصور / الفيديوات", fontWeightDelta: 3, color: TColors.buttonSecondary,),
          showAction: true,
        ),
        body:  Padding(
          padding: EdgeInsets.all(8.adaptSize),
          child: Obx(() => Directionality(
            textDirection: TextDirection.rtl,
            child: GridLayout(
              itemCount: controller.allMedia.length + 1, // +1 pour l'upload
              mainAxisExtent: isTablet ? 220.adaptSize : 180.adaptSize,
              crossAxisCount: 3,
              itemBuilder: (context, index) {
                if (index == 0) {
                  // L'icône upload
                  return TRoundedContainer(
                    showBorder: false,
                    backgroundColor: TColors.white,
                    borderColor: TColors.greyDating,
                    radius: 12,
                    padding: EdgeInsets.all(1),
                    child: CustomImageView(
                      imagePath: ImageConstant.uploadImage,
                      height: 100.adaptSize,
                      width: 100.adaptSize,
                      fit: BoxFit.fill,
                      onTap: () async {
                        await controller.showBottomSheetMedia(context);
                        //buildImagePickerOptions(context);
                        //await controller.pickMedia(context);
                      },
                    ),
                  );
                } else {
                  final media = controller.allMedia[index - 1]; // -1 car le 1er est upload
                  return TRoundedContainer(
                    showBorder: true,
                    backgroundColor: TColors.white,
                    borderColor: TColors.greyDating,
                    radius: 12,
                    padding: EdgeInsets.all(1),
                    child: Stack(
                      children: [
                        if(media.type == MessageType.image)
                          media.file != null
                          ? CustomImageView(
                            file: media.file,
                            imagePath: null,
                            height: Get.height,
                            width: Get.width,
                            fit: BoxFit.cover,
                            radius: BorderRadius.circular(10),
                          )
                        : CustomImageView(
                            imagePath: media.url,
                            height: Get.height,
                            width: Get.width,
                            fit: BoxFit.cover,
                            radius: BorderRadius.circular(10),
                          ),

                        if(media.type == MessageType.video)
                          VideoPreviewWidget(file: media.file),

                        Positioned(
                          right: 1,
                          top: 1,
                          child: CustomImageView(
                            imagePath: ImageConstant.removeImage,
                            width: 30.adaptSize,
                            height: 30.adaptSize,
                            radius: BorderRadius.circular(30.adaptSize),
                            fit: BoxFit.cover,
                            onTap: (){
                              controller.removeMedia(index - 1);
                            },
                          )
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
           /* child: GridLayout(
              itemCount: controller.selectedMedia.length + 1, // +1 pour l'upload
              mainAxisExtent: isTablet ? 220.adaptSize : 180.adaptSize,
              crossAxisCount: 3,
              itemBuilder: (context, index) {
                if (index == 0) {
                  // L'icône upload
                  return TRoundedContainer(
                    showBorder: false,
                    backgroundColor: TColors.white,
                    borderColor: TColors.greyDating,
                    radius: 12,
                    padding: EdgeInsets.all(1),
                    child: CustomImageView(
                      imagePath: ImageConstant.uploadImage,
                      height: 100.adaptSize,
                      width: 100.adaptSize,
                      fit: BoxFit.fill,
                      onTap: () async {
                        await controller.showBottomSheetMedia(context);
                        //buildImagePickerOptions(context);
                        //await controller.pickMedia(context);
                      },
                    ),
                  );
                } else {
                  final file = controller.selectedMedia[index - 1]; // -1 car le 1er est upload
                  return TRoundedContainer(
                    showBorder: true,
                    backgroundColor: TColors.white,
                    borderColor: TColors.greyDating,
                    radius: 12,
                    padding: EdgeInsets.all(1),
                    child: Stack(
                      children: [
                        // Utiliser CustomImageView au lieu de Image.file
                        CustomImageView(
                          file: file,
                          imagePath: null,
                          //imagePath: file.path, // très important: .path car File
                          height: Get.height,
                          width: Get.width,
                          fit: BoxFit.cover,
                          radius: BorderRadius.circular(10),
                        ),
                        Positioned(
                            right: 1,
                            top: 1,
                            child: CustomImageView(
                              imagePath: ImageConstant.removeImage,
                              width: 30.adaptSize,
                              height: 30.adaptSize,
                              radius: BorderRadius.circular(30.adaptSize),
                              fit: BoxFit.cover,
                              onTap: (){
                                controller.removeMedia(index - 1);
                              },
                            )
                        ),
                      ],
                    ),
                  );
                }
              },
            ) */
          )),
        ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: TSizes.spaceBtwSections.v, left: TSizes.spaceBtwItems.hw, right: TSizes.spaceBtwItems.hw),
            //child: _buildButtonSection()
            child:
            CustomButtonContainer(
              text:"حفظ التغييرات".tr,
              color1: TColors.yellowAppDark,
              color2: TColors.yellowAppLight,
              borderRadius: 10,
              colorText: TColors.white,
              fontSize: 30.adaptSize,
              height: 80.v,
              onPressed: () async {
                //dialogVerifyAccount(context);
              },
            ),
          ),
    )
    )
    );
  }

   Widget buildImagePickerOptions(BuildContext context) {
     return SafeArea(
       child: Wrap(
         children: [
           ListTile(
             leading: const Icon(Icons.photo),
             title: const Text("Gallery"),
             onTap: () async {
               await controller.pickMedia(context, ImageSource.gallery);
               Navigator.pop(context);
             },
           ),
           ListTile(
             leading: const Icon(Icons.camera_alt),
             title: const Text("Camera"),
             onTap: () async {
               await controller.pickMedia(context, ImageSource.camera);
               Navigator.pop(context);
             },
           ),
         ],
       ),
     );
   }
}
