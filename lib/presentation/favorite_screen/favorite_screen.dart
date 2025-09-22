import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/favorite_screen/controller/favorite_controller.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/fullscreen_image_viewer.dart';
import 'package:dating_app_bilhalal/widgets/custom_search_view.dart';
import 'package:dating_app_bilhalal/widgets/grid_layout.dart';
import 'package:dating_app_bilhalal/widgets/home/favorite_list_view.dart';
import 'package:dating_app_bilhalal/widgets/home/tabbed_page_widget.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatelessWidget {
  final controller = Get.put(FavoriteController());
  final FocusNode _focusNode = FocusNode();

  FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenheight = mediaQueryData.size.height;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return SafeArea(
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Obx(() => Column(
            children: [
              // Search
              SizedBox(height: TSizes.spaceBtwSections.v),
              CustomSearchView(
                width: mediaQueryData.size.width * 0.9,
                fillColor: TColors.white,
                controller: controller.searchController,
                focusNode: _focusNode,
                hintText: "بحث".tr,
                onChanged: controller.onSearchChanged,
                autofocus: false,
                borderDecoration: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.hw),
                    borderSide: BorderSide(color: TColors.greyDating, width: 1)
                ),
              ),

              SizedBox(height: TSizes.spaceBtwSections.v),
              // TabbedPage générique
              TabbedPageWidget(
                tabs: [
                  TabItem("الملفات الشخصية المفضلة"),
                  TabItem("الصور و الفيديوات المفضلة")
                ],
                onTabChanged: controller.onTabChanged,
                activeColor: TColors.yellowAppDark,
                inactiveColor: TColors.black,
              ),

              // Favorite Users
              if(controller.selectedTab.value == 1)
                Expanded(
                  child: FavoriteListView(
                    items: controller.filteredFavorisUsers,
                    onItemTap: (chat) {
                      // Navigation vers le chat détaillé
                      Get.toNamed(Routes.discussionDetailsScreen, arguments: {
                        "ChatDiscussion" : chat
                      });
                    },
                  )
                ),

              //Favorite Images & Videos
              if(controller.selectedTab.value == 2)
                GridLayout(
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
            ],
          )),
        ),
      ),
    );
  }
}