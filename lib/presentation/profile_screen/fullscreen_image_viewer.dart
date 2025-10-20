import 'package:carousel_slider/carousel_slider.dart';
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/user_model.dart';
import 'package:dating_app_bilhalal/widgets/circle_icon_button.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
import 'package:dating_app_bilhalal/widgets/custom_divider.dart';
import 'package:dating_app_bilhalal/widgets/gradient/gradient_svg_icon.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:dating_app_bilhalal/widgets/subtitle_widget.dart';
import 'package:flutter/material.dart';

class FullScreenImageViewer extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const FullScreenImageViewer({
    Key? key,
    required this.images,
    required this.initialIndex,
  }) : super(key: key);

  @override
  _FullScreenImageViewerState createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  var _appTheme = PrefUtils.getTheme();
  final CarouselController _carouselController = CarouselController();
  late int currentIndex;
  var currentWeightValue = 10.toDouble();

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  void _goToPage(int index) {
    _carouselController.animateToPage(index);
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenheight = mediaQueryData.size.height;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          /// ✅ Carousel plein écran
          CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: widget.images.length,
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              viewportFraction: 1,
              enlargeCenterPage: false,
              enableInfiniteScroll: false,
              autoPlay: false,
              initialPage: currentIndex,
              onPageChanged: (index, reason) {
                setState(() => currentIndex = index);
              },
            ),
            itemBuilder: (context, index, realIndex) {
              return CustomImageView(
                imagePath: widget.images[index],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              );
             /* return Image.asset(
                widget.images[index],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ); */
            },
          ),

          /// ✅ Bouton fermer
          Positioned(
            top: 40,
            right: 20,
           child: IconButton(
             icon: Icon(Icons.close, color: TColors.primaryColorApp, size: 40.adaptSize),
             onPressed: (){
               Navigator.pop(context);
             },
           ),
           /* child: CircleIconButton(
              size: 60.adaptSize,
              effectiveSize: 60.adaptSize,
              minTapSize: 55.adaptSize,
                backgroundColor: TColors.greyDating.withOpacity(0.9),
                child: IconButton(
                  icon: Icon(Icons.close, color: TColors.grey400.withOpacity(1), size: 35.adaptSize,),
                  onPressed: (){
                    Navigator.pop(context);
                  },
                ),
              ) */
          ),

          /// ✅ Flèche gauche
          if (currentIndex > 0)
            Positioned(
              left: 10,
              top: MediaQuery.of(context).size.height / 2 - 30,
            child:  Directionality(
              textDirection: TextDirection.ltr,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: TColors.primaryColorApp, size: 40.adaptSize),
                onPressed: (){
                  _goToPage(currentIndex - 1);
                },
              ),
            ),
            /*  child: CircleIconButton(
                size: 60.adaptSize,
                effectiveSize: 60.adaptSize,
                minTapSize: 60.adaptSize,
                  backgroundColor: TColors.greyDating.withOpacity(0.9),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: TColors.grey400.withOpacity(1), size: 35.adaptSize,),
                    onPressed: (){
                      _goToPage(currentIndex - 1);
                    },
                  ),
                ) */
            ),

          /// ✅ Flèche droite
          if (currentIndex < widget.images.length - 1)
            Positioned(
              right: 10,
              top: MediaQuery.of(context).size.height / 2 - 30,
             child:  Directionality(
               textDirection: TextDirection.ltr,
               child: IconButton(
                 icon: Icon(Icons.arrow_forward, color: TColors.primaryColorApp, size: 40.adaptSize,),
                 onPressed: (){
                   _goToPage(currentIndex + 1);
                 },
               ),
             ),
             /* child: CircleIconButton(
                size: 60.adaptSize,
                effectiveSize: 60.adaptSize,
                minTapSize: 60.adaptSize,
                  backgroundColor: TColors.greyDating.withOpacity(0.9),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward, color: TColors.grey400.withOpacity(1), size: 35.adaptSize,),
                    onPressed: (){
                      _goToPage(currentIndex + 1);
                    },
                  ),
                ) */
            ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: screenheight * 0.2, // effet plus grand
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,       // Haut → totalement transparent
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.8), // Bas → plus opaque
                    ],
                    stops: const [0.0, 0.4, 0.7, 1.0],
                  )
              ),
              /*
              child: TRoundedContainer(
                      width: double.infinity,
                      height: isSmallPhone ? (screenheight * 0.17) : (screenheight * 0.14),
                      backgroundColor: Colors.black.withOpacity(0.5),
                      radius: 1.adaptSize,
                      isBorderRadiusTop: true,
                      padding: EdgeInsets.symmetric(
                      horizontal: TSizes.spaceBtwItems.hw,
                      vertical: 10.v),
               */
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Dialogs.buildDialogUsersLikes(context, 20,
                            [
                              UserModel(
                                  imageProfile: ImageConstant.imgOnBoarding1,
                                  fullName: 'نورا خالد',
                                  age: 25,
                                  bio: 'نموذج احترافي',
                                  isFavoris: true,
                                  interests: ["التسوق", "فوتوغرافيا", "اليوغا"],
                                  images: [ImageConstant.profile1, ImageConstant.profile2, ImageConstant.profile3, ImageConstant.profile4, ImageConstant.profile5, ImageConstant.profile6, ImageConstant.profile7]
                              ),
                              UserModel(
                                  imageProfile: ImageConstant.imgOnBoarding2,
                                  fullName: 'نورا خالد',
                                  age: 32,
                                  bio: 'مبرمج',
                                  isFavoris: true,
                                  interests: ["كاريوكي", "التنس", "اليوغا", "طبخ", "سباحة"],
                                  images: [ImageConstant.profile1, ImageConstant.profile2, ImageConstant.profile3, ImageConstant.profile4, ImageConstant.profile5, ImageConstant.profile6, ImageConstant.profile7]
                              ),
                              UserModel(
                                  imageProfile: ImageConstant.imgOnBoarding3,
                                  fullName: 'ايلاف خالد',
                                  age: 29,
                                  bio: 'شخص إعلامي',
                                  isFavoris: false,
                                  interests: ["ركض", "السفر", "قراءة", "طبخ", "سباحة"],
                                  images: [ImageConstant.profile1, ImageConstant.profile2, ImageConstant.profile3, ImageConstant.profile4, ImageConstant.profile5, ImageConstant.profile6, ImageConstant.profile7]
                              ),
                              UserModel(
                                  imageProfile: ImageConstant.imgOnBoarding4,
                                  fullName: 'إسراء الجديدي',
                                  age: 22,
                                  bio: 'شخص إعلامي',
                                  isFavoris: true,
                                  interests: ["السفر", "قراءة", "طبخ", "سباحة"],
                                  images: [ImageConstant.profile1, ImageConstant.profile2, ImageConstant.profile3, ImageConstant.profile4, ImageConstant.profile5, ImageConstant.profile6, ImageConstant.profile7]
                              ),
                            ]);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GradientSvgIcon(
                            assetPath: ImageConstant.iconLove,
                            size: 50.adaptSize,
                            gradient: const LinearGradient(
                              colors: [TColors.redApp, TColors.redApp],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          SizedBox(height:2),
                          /*
                          CircleIconButton(
                            size: 66.hw,
                            effectiveSize: 66.hw,
                            minTapSize: 66.hw,
                            backgroundColor: TColors.greyDating.withOpacity(0.9),
                            //margin: EdgeInsets.symmetric(horizontal: 10.hw),
                            child: IconButton(
                              icon: Icon(Iconsax.heart5, color: TColors.redAppLight, size: 45.hw,),
                              onPressed: (){
                                _goToPage(currentIndex + 1);
                              },
                            ),
                          ),
                           */
                          SubTitleWidget(subtitle: '23', color: TColors.white, fontWeightDelta: 2,),
                        ],
                      ),
                    ),
                   /* for(var image in widget.images){
                      if(image.endsWith('.mp4')){

                      }
                    } */
                    Visibility(
                      visible: false,
                      child: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: [TColors.greyDating, TColors.redAppLight], // ✅ Dégradé
                          ).createShader(bounds);
                        },
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 8, // ✅ Augmenter la hauteur du slider
                            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                            overlayShape: const RoundSliderOverlayShape(overlayRadius: 20),
                            valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                            valueIndicatorTextStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            showValueIndicator: ShowValueIndicator.always, // ✅ Toujours afficher label
                          ),
                          child: Slider(
                            value: currentWeightValue,
                            min: 0,
                            max: 140,
                            divisions: 140,
                            label: currentWeightValue.round().toString(),
                            onChanged: (value) {
                              setState(() {
                                currentWeightValue = value;
                              });
                            },
                            activeColor: Colors.white, // ✅ Couleur appliquée par gradient
                            inactiveColor: Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
                      )
          )
        ],
      ),
    );
  }

}

///PageView
/*
class _FullScreenImageViewerState extends State<FullScreenImageViewer> {
  late PageController _pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: currentIndex);
  }

  void _goToPage(int index) {
    if (index >= 0 && index < widget.images.length) {
      _pageController.jumpToPage(index);
      setState(() => currentIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Images avec swipe
          Positioned.fill(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) => setState(() => currentIndex = index),
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return InteractiveViewer(
                    panEnabled: true,
                    child: CustomImageView(
                      imagePath: widget.images[index],
                      width: Get.width,
                      height: Get.height,
                      fit: BoxFit.contain,
                    )
                  /* Image.network(
                    widget.images[index],
                    fit: BoxFit.contain,
                  ), */
                );
              },
            ),
          ),

          // Bouton fermer
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          // Flèche gauche
          if (currentIndex > 0)
            Positioned(
              left: 10,
              top: MediaQuery.of(context).size.height / 2 - 30,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white, size: 40),
                onPressed: () => _goToPage(currentIndex - 1),
              ),
            ),

          // Flèche droite
          if (currentIndex < widget.images.length - 1)
            Positioned(
              right: 10,
              top: MediaQuery.of(context).size.height / 2 - 30,
              child: IconButton(
                icon: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 40),
                onPressed: () => _goToPage(currentIndex + 1),
              ),
            ),
        ],
      ),
    );
  }
}
*/
