import 'package:dating_app_bilhalal/core/utils/size_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

import 'shimmer_effect.dart';

class CardSwiperShimmer extends StatelessWidget {
  const CardSwiperShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return CardSwiper(
      cardsCount: 1,
      numberOfCardsDisplayed: 1,
      isLoop: true,
      padding: EdgeInsets.zero,
      duration: Duration(milliseconds: 10),
      allowedSwipeDirection: const AllowedSwipeDirection.only(
        up: false,
        down: false,
        left: false,
        right: false,
      ),
      onSwipe: (previousIndex, currentIndex, direction) {
        return false;
      },
      //maxAngle: 30,
      cardBuilder: (context, index, percentX, percentY) {
        return ClipRRect(
          borderRadius: BorderRadius.zero, // ✅ enlève coins arrondis du Card
          child: Stack(
            children: [
              // background image (fills)
              Positioned.fill(
                child: ShimmerEffect(width: mediaQueryData.size.width, height: mediaQueryData.size.height)
              ),
              // 🔥 Dégradé progressif noir transparent vers noir
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: mediaQueryData.size.height * 0.3, // effet plus grand
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Left side: fixed-size vertical icon column
                              SizedBox(
                                width: mediaQueryData.size.width * 0.3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                   ShimmerEffect(width: 40.hw, height: 40.hw),
                                    SizedBox(width: 10.hw,),
                                    ShimmerEffect(width: 40.hw, height: 40.hw),
                                  ],
                                ),
                              ),

                              SizedBox(width: mediaQueryData.size.width * 0.1),

                              // --- Infos utilisateur
                              // Right side: text info - put into Expanded/Flexible so it can't overflow the row
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          ShimmerEffect(width: 70.hw, height: 15.v),
                                          SizedBox(width: 5.adaptSize),
                                          CircleAvatar(radius: 6, backgroundColor: Colors.grey)
                                        ],
                                      ),

                                    const SizedBox(height: 6),
                                    // bio - allow up to 2 lines then ellipsis
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          ShimmerEffect(width: 90.hw, height: 15.v),
                                          SizedBox(width: 10.adaptSize),
                                          ShimmerEffect(width: 20.hw, height: 20.hw),
                                        ],
                                      ),

                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}