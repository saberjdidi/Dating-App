import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/chat_screen/controller/chat_controller.dart';
import 'package:dating_app_bilhalal/widgets/app_bar/appbar_widget.dart';
import 'package:dating_app_bilhalal/widgets/custom_search_view.dart';
import 'package:dating_app_bilhalal/widgets/chat/chat_list_view.dart';
import 'package:dating_app_bilhalal/widgets/home/tabbed_page_widget.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});
  final controller = Get.put(ChatController());
  final FocusNode _focusNode = FocusNode();
  var _appTheme = PrefUtils.getTheme();


  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: TAppBar(
          title: TitleWidget(
              title: "الدردشة", fontWeightDelta: 3,
              color: _appTheme =='light' ? TColors.buttonSecondary : TColors.white,
          ),
          showAction: false,
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              // Search
              SizedBox(height: TSizes.spaceBtwItems.v),
              CustomSearchView(
                width: mediaQueryData.size.width * 0.9,
                fillColor: TColors.greyContainerChat,
                controller: controller.searchController,
                focusNode: _focusNode,
                hintText: "بحث".tr,
                onChanged: controller.onSearchChanged,
                autofocus: false,
                borderDecoration: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.hw),
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
                activeColor: Color(0xFF09AFFF),
                inactiveColor: _appTheme =='light' ? TColors.black : TColors.white,
              ),

              // Liste
              Expanded(
                child: Obx(() => ChatListView(
                  chats: controller.filteredChats,
                  onItemTap: (chat) {
                    // Navigation vers le chat détaillé
                    Get.toNamed(Routes.messageScreen, arguments: {
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

