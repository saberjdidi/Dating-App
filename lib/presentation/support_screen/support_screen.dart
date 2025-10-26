import 'package:dating_app_bilhalal/core/utils/pref_utils.dart';
import 'package:dating_app_bilhalal/presentation/support_screen/controller/support_controller.dart';
import 'package:dating_app_bilhalal/widgets/app_bar/appbar_widget.dart';
import 'package:dating_app_bilhalal/widgets/chat/video_preview_widget.dart';
import 'package:dating_app_bilhalal/widgets/custom_text_form_field.dart';
import 'package:dating_app_bilhalal/widgets/grid_layout.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/swip_back_wrapper.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:dating_app_bilhalal/widgets/video_preview_gallery.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/app_export.dart';

class SupportScreen extends GetView<SupportController> {
   SupportScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKeySupport = GlobalKey<ScaffoldState>();
  var _appTheme = PrefUtils.getTheme();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return SafeArea(
        top: false,
        child: SwipeBackWrapper(
          child: Form(
            key: controller.formSupportKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Scaffold(
              key: _scaffoldKeySupport,
              resizeToAvoidBottomInset: false,
              //backgroundColor: _appTheme =='light' ? TColors.white : appTheme.primaryColor,
              appBar: TAppBar(
                title: TitleWidget(title: "الدعم", fontWeightDelta: 3,
                    color: _appTheme =='light' ? TColors.buttonSecondary : TColors.white),
                showAction: true,
              ),
              body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(horizontal: 24.hw, vertical: 11.v),
                      child:  Directionality(
                        textDirection: TextDirection.rtl,
                        child: Obx(() => Column(
                            children: [
                              Visibility(
                                visible: false,
                                child: Text("طرح موضوع",
                                    style: Theme.of(context).textTheme.headlineSmall!
                                        .apply(color: _appTheme =='light' ? TColors.black : TColors.white,
                                        fontWeightDelta: 2, fontSizeDelta: 2),
                                    textAlign: TextAlign.center),
                              ),
                              SizedBox(height: TSizes.spaceBtwSections),

                              CustomTextFormField(
                                controller: controller.subjectController,
                                hintText: "${'الموضوع'.tr} *",
                                onChange: (value){
                                  controller.onSubjectChanged(value);
                                  controller.isRTL.value = TDeviceUtils.isArabic(value);
                                },
                                validator: (value) => (value == null || value.isEmpty) ? "الموضوع إجباري" : null,
                                focusNode: controller.subjectFocus,
                                onTap: () => FocusScope.of(context).requestFocus(controller.subjectFocus),
                                onEditingComplete: () => FocusScope.of(context).requestFocus(controller.messageFocus),
                                textInputType: TextInputType.text,
                                prefixConstraints: BoxConstraints(maxHeight: 60.v),
                                contentPadding: EdgeInsets.only(top: 18.v, right: 30.hw, left: 30.hw, bottom: 18.v),
                                fillColor: _appTheme =='light' ? TColors.white : TColors.dark,
                                hintStyle: _appTheme =='light' ? CustomTextStyles.titleMediumSemiBoldBlack : CustomTextStyles.titleMediumSemiBoldWhite,
                                textStyle: _appTheme =='light' ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
                              ),
                              /// --- Compteur sous le champ
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  controller.subjectError.value.isNotEmpty
                                      ? controller.subjectError.value
                                      : "${controller.subjectRemaining.value} حرف متبقي",
                                  style: TextStyle(
                                    fontSize: 15.adaptSize,
                                    color: controller.subjectError.value.isNotEmpty
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(height: TSizes.spaceBtwInputFields.adaptSize),

                              CustomTextFormField(
                                controller: controller.messageController,
                                hintText: "${'رسالة'.tr} *",
                                onChange: (value){
                                  controller.onMessageChanged(value);
                                  controller.isRTL.value = TDeviceUtils.isArabic(value);
                                },
                                validator: (value) => (value == null || value.isEmpty) ? "الرسالة إجباري" : null,
                                focusNode: controller.messageFocus,
                                onTap: () => FocusScope.of(context).requestFocus(controller.messageFocus),
                                onEditingComplete: () => FocusScope.of(context).requestFocus(controller.messageFocus),
                                maxLines: 4,
                                textInputType: TextInputType.text,
                                prefixConstraints: BoxConstraints(maxHeight: 60.v),
                                contentPadding: EdgeInsets.only(top: 18.v, right: 30.hw, left: 30.hw, bottom: 18.v),
                                fillColor: _appTheme =='light' ? TColors.white : TColors.dark,
                                hintStyle: _appTheme =='light' ? CustomTextStyles.titleMediumSemiBoldBlack : CustomTextStyles.titleMediumSemiBoldWhite,
                                textStyle: _appTheme =='light' ? CustomTextStyles.bodyMediumTextFormField : CustomTextStyles.bodyMediumTextFormFieldWhite,
                              ),
                              /// --- Compteur sous le champ
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  controller.messageError.value.isNotEmpty
                                      ? controller.messageError.value
                                      : "${controller.messageRemaining.value} حرف متبقي",
                                  style: TextStyle(
                                    fontSize: 15.adaptSize,
                                    color: controller.messageError.value.isNotEmpty
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                              SizedBox(height: TSizes.spaceBtwInputFields.adaptSize),

                              GridLayout(
                                itemCount: 1, // un seul élément : soit l’icône d’upload, soit l’image sélectionnée
                                mainAxisExtent: isTablet ? 200.adaptSize : 150.adaptSize,
                                crossAxisCount: 3,
                                itemBuilder: (context, index) {
                                  return Obx(() {
                                    final file = controller.selectedMedia.value;
                                    final mediaType = controller.mediaType.value; // "image" ou "video"

                                    // ✅ Si aucun média n’a encore été choisi
                                    // 🟢 Aucun média sélectionné → bouton upload
                                    if (file == null) {
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
                                            await controller.pickMedia();
                                          },
                                        ),
                                      );
                                    }

                                    // ✅ Si un média est sélectionné
                                    return TRoundedContainer(
                                      showBorder: true,
                                      backgroundColor: TColors.white,
                                      borderColor: TColors.greyDating,
                                      radius: 12,
                                      padding: EdgeInsets.all(1),
                                      child: Stack(
                                        children: [
                                           mediaType == "video"
                                                ? ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: VideoPreviewGallery(
                                                    file: file,
                                                    url: null,
                                                  ),
                                                )
                                             : CustomImageView(
                                                file: file,
                                                imagePath: null,
                                                height: Get.height,
                                                width: Get.width,
                                                fit: BoxFit.cover,
                                                radius: BorderRadius.circular(10),
                                              ),
                                          Positioned(
                                            right: 0,
                                            top: 0,
                                            child: CustomImageView(
                                              imagePath: ImageConstant.removeImage,
                                              width: 30.adaptSize,
                                              height: 30.adaptSize,
                                              radius: BorderRadius.circular(30.adaptSize),
                                              fit: BoxFit.cover,
                                              onTap: controller.removeMedia,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });

                                },
                              ),

                              ///Select many files
                              /*
                              GridLayout(
                                itemCount: controller.selectedMedia.length + 1, // +1 pour l'upload
                                mainAxisExtent: isTablet ? 200.adaptSize : 150.adaptSize,
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
                                          await controller.pickMedia();
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
                                            right: 0,
                                            child: CustomImageView(
                                              imagePath: ImageConstant.removeImage,
                                              width: 30.adaptSize,
                                              height: 30.adaptSize,
                                              radius: BorderRadius.circular(30.adaptSize),
                                              fit: BoxFit.cover,
                                              onTap: (){
                                                controller.removeMedia(index - 1);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                },
                              )
                              */
                            ]
                        )),
                      ))
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(bottom: TSizes.spaceBtwSections.v , left: TSizes.spaceBtwItems.hw, right: TSizes.spaceBtwItems.hw),
                //child: _buildButtonSection()
                child: Obx(() => CustomButtonContainer(
                  text:"يحفظ".tr,
                  color1: TColors.primaryColorApp,
                  color2: TColors.primaryColorApp,
                  borderRadius: 20.adaptSize,
                  colorText: TColors.white,
                  fontSize: isTablet ? 30.adaptSize : 22.adaptSize,
                  height: isSmallPhone ? 80.v : 70.v,
                  width: Get.width,
                  onPressed: controller.isDataProcessing.value
                      ? null // désactive le clic pendant chargement
                      : () async {
                    controller.savedFn();
                  },
                  child: controller.isDataProcessing.value
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
            ),
          ),
        ));
  }

  /// Navigates to the previous screen.
  onTapImgArrowLeft() {
    //Get.back();
    SystemNavigator.pop(); // Exit the app
  }
}
