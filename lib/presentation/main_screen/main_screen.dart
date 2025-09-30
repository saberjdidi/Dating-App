
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/country_model.dart';
import 'package:dating_app_bilhalal/presentation/main_screen/controller/main_controller.dart';
import 'package:dating_app_bilhalal/widgets/home/pays_widget.dart';
import 'package:dating_app_bilhalal/widgets/home/user_card_widget.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class MainScreen extends GetView<MainController> {
//class MainScreen extends StatelessWidget {
   MainScreen({super.key});

  //final controller = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text("Dating App")),
      body: Obx(() {
        if (controller.users.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return CardSwiper(
          cardsCount: controller.users.length,
          numberOfCardsDisplayed: 1,
          isLoop: true,
          padding: EdgeInsets.zero,
          //maxAngle: 30,
          cardBuilder: (context, index, percentX, percentY) {
            final user = controller.users[index];
            return UserCardWidget(
              user: user,
              onMessageTap: () async {
                await dialogSearchByCountry(context);
              },
              onFavoriteTap: () => debugPrint("Favorite ${user.fullName}"),
             /* onTapFilter: () async {
                await dialogSearchByCountry(context);
              }, */
            );
          },
        );
      }),
    );
  }

  dialogSearchByCountry(BuildContext context) async {
    var screenWidth = MediaQuery.of(context).size.width;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    //controller.searchVilleController.clear();

    await Dialogs.customModalBottomSheet(
        context,
        0.7,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.fSize, vertical: TSizes.spaceBtwItems.fSize),
          child: ListBody(
            children: <Widget>[
           /*   Center(
                child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.keyboard_arrow_down_rounded, color: TColors.textSecondary, size: 40.adaptSize,)
                ),
              ), */
              SizedBox(height: TSizes.spaceBtwSections.adaptSize),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.adaptSize),
                child: TitleWidget(title: "اختر الدولة".tr,
                    textAlign: TextAlign.right),
              ),
              SizedBox(height: TSizes.spaceBtwSections.adaptSize),
              Obx(() => GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 2.2,
                children: countriesList.map((country) {
                  final isSelected = controller.selectedCountries.contains(country.name);
                  return PaysWidget(
                    text: country.name,
                    imagePath: country.imagePath,
                    isSelected: isSelected,
                    onTap: () => controller.toggleCountry(country.name),
                  );
                }).toList(),
              )),
               SizedBox(height: TSizes.spaceBtwItems.v),
              SizedBox(
                width: isTablet ? mediaQueryData.size.width * 0.2 : mediaQueryData.size.width * 0.4,
                child: CustomButtonContainer(
                  text:"حفظ التغييرات".tr,
                  color1: TColors.yellowAppDark,
                  color2: TColors.yellowAppLight,
                  borderRadius: 10,
                  colorText: TColors.redAppLight,
                  fontSize: 20.adaptSize,
                  onPressed: () async {
                    //controller.saveBtn();
                  },
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems,),
            ],
          )
        )
    );
  }
}
