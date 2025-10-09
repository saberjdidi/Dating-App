import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/favorite_screen/controller/favorite_controller.dart';
import 'package:dating_app_bilhalal/presentation/profile_screen/fullscreen_image_viewer.dart';
import 'package:dating_app_bilhalal/widgets/app_bar/appbar_widget.dart';
import 'package:dating_app_bilhalal/widgets/custom_search_view.dart';
import 'package:dating_app_bilhalal/widgets/grid_layout.dart';
import 'package:dating_app_bilhalal/widgets/home/favorite_list_view.dart';
import 'package:dating_app_bilhalal/widgets/home/tabbed_page_widget.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({super.key});
  final controller = Get.put(FavoriteController());
  final FocusNode _focusNode = FocusNode();
  var _appTheme = PrefUtils.getTheme();


  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenheight = mediaQueryData.size.height;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;
    // Déterminer le nombre de colonnes dynamiquement
    int crossAxisCount = screenWidth < 600 ? 2 : 3;

    return SafeArea(
      child: Scaffold(
        appBar: TAppBar(
          title: TitleWidget(title: "المفضلة", fontWeightDelta: 3,
              color: _appTheme =='light' ? TColors.buttonSecondary : TColors.white),
          showAction: false,
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Obx(() => Column(
            children: [
              //SizedBox(height: 10.v),
              // Search
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.hw),
                child: TabbedPageWidget(
                  tabs: [
                    TabItem("الحسابات المفضلة"),
                    TabItem("ملفي المفضل"),
                    TabItem("الصور المفضلة")
                  ],
                  onTabChanged: controller.onTabChanged,
                  activeColor: TColors.yellowAppDark,
                  inactiveColor: _appTheme =='light' ? TColors.black : TColors.white,
                ),
              ),
              SizedBox(height: 5.v),

              // Favorite Users
              if(controller.selectedTab.value == 0)
                Expanded(
                  child: FavoriteListView(
                    items: controller.filteredFavorisUsers,
                    onItemTap: (chat) {
                      // Navigation vers le chat détaillé
                      Get.toNamed(Routes.messageScreen, arguments: {
                        "ChatDiscussion" : chat
                      });
                    },
                  )
                ),

              if(controller.selectedTab.value == 1)
                Expanded(
                    child: FavoriteListView(
                      items: controller.filteredFavorisUsers,
                      onItemTap: (chat) {
                        // Navigation vers le chat détaillé
                        Get.toNamed(Routes.messageScreen, arguments: {
                          "ChatDiscussion" : chat
                        });
                      },
                    )
                ),

              //Favorite Images & Videos
              if(controller.selectedTab.value == 2)
                Expanded(
                  child: MasonryGridView.builder(
                    itemCount: controller.ListImages.value.length,
                      gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: crossAxisCount),
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      itemBuilder: (context, index) => TRoundedContainer(
                        showBorder: true,
                        backgroundColor: TColors.white,
                        borderColor: TColors.greyDating,
                        radius: 15,
                        padding: EdgeInsets.all(2),
                        child: CustomImageView(
                          //file: file,
                          imagePath: controller.ListImages.value[index],
                          //imagePath: file.path, // très important: .path car File
                          //height: 200.v,
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
                      )
                  ),
                ),
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
                ), */
            ],
          )),
        ),
      ),
    );
  }
}