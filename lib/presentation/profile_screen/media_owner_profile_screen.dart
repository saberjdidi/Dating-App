
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/controller/media_owner_profile_controller.dart';
import 'package:dating_app_bilhalal/widgets/app_bar/appbar_widget.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
import 'package:dating_app_bilhalal/widgets/grid_layout.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:dating_app_bilhalal/widgets/chat/video_preview_widget.dart';
import 'package:dating_app_bilhalal/widgets/video_preview_gallery.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MediaOwnerProfileScreen extends GetWidget<MediaOwnerProfileController> {
   MediaOwnerProfileScreen({super.key});

   final GlobalKey<ScaffoldState> _scaffoldKeyMediaProfile = GlobalKey<ScaffoldState>();
  var _appTheme = PrefUtils.getTheme();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return SafeArea(
        top: false,
        child: Scaffold(
          key: _scaffoldKeyMediaProfile,
        //backgroundColor: _appTheme =='light' ? TColors.white : appTheme.primaryColor,
        appBar: TAppBar(
          title: SubTitleWidget(fontSizeDelta: 5, fontWeightDelta: 2,subtitle: "تعديل الصور / الفيديوات", color: TColors.buttonSecondary,),
          showAction: true,
        ),
        body:  Padding(
          padding: EdgeInsets.all(8.adaptSize),
          child: Obx((){
            if (controller.isDataProcessing.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return Directionality(
              textDirection: TextDirection.rtl,
              child: GridLayout(
                itemCount: controller.allMedia.length + 1, // +1 pour l'upload
                mainAxisExtent: isTablet ? 220.adaptSize : 180.adaptSize,
                crossAxisCount: 3,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    // ✅ Bouton Upload
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
                        },
                      ),
                    );
                  } else {

                    final media = controller.allMedia[index - 1]; // -1 car le 1er est upload
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
                              if (media.mediaType == "image")
                                CustomImageView(
                                  file: media.file,
                                  imagePath: media.file == null ? media.mediaUrl : null,
                                  height: Get.height,
                                  width: Get.width,
                                  fit: BoxFit.cover,
                                  radius: BorderRadius.circular(10),
                                ),
                          /*
                            if (media.mediaType == "image")
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
                              imagePath: media.mediaUrl,
                            height: Get.height,
                            width: Get.width,
                            fit: BoxFit.cover,
                            radius: BorderRadius.circular(10),
                            ), */

                          // ✅ Vidéo
                          if (media.mediaType == "video")
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: VideoPreviewGallery(
                                file: media.file,
                                url: media.file == null ? media.mediaUrl : null,
                              ),
                            ),
                           /* media.file != null
                                ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                height: 200, //height: Get.height,
                                width: MediaQuery.of(context).size.width * 0.9,//width: double.infinity,
                                child: VideoPreviewWidget(file: media.file, url: null,),
                              ),
                            )
                                : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: SizedBox(
                                height: Get.height,
                                width: double.infinity,
                                child: VideoPreviewWidget(url: media.mediaUrl),
                              ),
                            ), */

                          Positioned(
                              right: 1,
                              top: 1,
                              child: CustomImageView(
                                imagePath: ImageConstant.removeImage,
                                width: 30.adaptSize,
                                height: 30.adaptSize,
                                radius: BorderRadius.circular(30.adaptSize),
                                fit: BoxFit.cover,
                                onTap: () {
                                  controller.removeMedia(index - 1);
                                },
                                //onTap: () => controller.deleteMedia(media.id),
                              )
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            );
          }),
        ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(bottom: TSizes.spaceBtwSections.v, left: TSizes.spaceBtwItems.hw, right: TSizes.spaceBtwItems.hw),
            //child: _buildButtonSection()
            child:  Obx(() => CustomButtonContainer(
              text:"حفظ".tr,
              color1: TColors.primaryColorApp,
              color2: TColors.primaryColorApp,
              borderRadius: 10,
              colorText: TColors.white,
              fontSize: 30.adaptSize,
              height: isTablet ? 80.v : 70.v,
              onPressed:controller.isDataCreateProcessing.value
                  ? null // désactive le clic pendant chargement
                  :  () async {
                controller.createMedia();
              },
              // onPressed: () async {controller.createAccount();},
              child: controller.isDataCreateProcessing.value
                  ? const SizedBox(
                height: 28,
                width: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
              )
                  : null,
            )),
          ),
            )
    );
  }

}
