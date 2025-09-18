
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/discussion_screen/controller/discussion_controller.dart';
import 'package:dating_app_bilhalal/widgets/custom_search_view.dart';
import 'package:dating_app_bilhalal/widgets/home/chat_list_view.dart';
import 'package:dating_app_bilhalal/widgets/home/tabbed_page_widget.dart';
import 'package:flutter/material.dart';

class DiscussionScreen extends StatelessWidget {
  final controller = Get.put(DiscussionController());
  final FocusNode _focusNode = FocusNode();

  DiscussionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
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
                  TabItem("الکل"),
                  TabItem("غير مقروء"),
                  TabItem("أرشيف"),
                ],
                onTabChanged: controller.onTabChanged,
                activeColor: TColors.yellowAppDark,
                inactiveColor: TColors.black,
              ),

              // Liste
              Expanded(
                child: Obx(() => ChatListView(
                  chats: controller.filteredChats,
                  onItemTap: (chat) {
                    // Navigation vers le chat détaillé
                    Get.toNamed(Routes.discussionDetailsScreen, arguments: {
                      "ChatDiscussion" : chat
                    });
                  },
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

