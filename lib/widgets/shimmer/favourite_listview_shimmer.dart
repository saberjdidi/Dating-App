import 'package:dating_app_bilhalal/core/utils/size_utils.dart';
import 'package:dating_app_bilhalal/widgets/shimmer/shimmer_effect.dart';
import 'package:flutter/material.dart';

class FavouriteListViewShimmer extends StatelessWidget {
  const FavouriteListViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenheight = mediaQueryData.size.height;
    var isSmallPhone = screenWidth < 360;
    const double bottomPadding = 8;
    const double horizontalPadding = 8;

    return ListView.builder(
      itemCount:4,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.adaptSize)),
          clipBehavior: Clip.hardEdge,
          margin: EdgeInsets.symmetric(vertical: 10.v, horizontal: 5.hw),
          child: SizedBox(
            height: screenheight * 0.3,
            child: Stack(
              children: [
                // background image (fills)
                Positioned.fill(
                  child: ShimmerEffect(width: mediaQueryData.size.width, height: mediaQueryData.size.height)
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: isSmallPhone ? 100.v : 90.v,
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding.hw,
                      vertical: bottomPadding.v,
                    ),
                    // Use a subtle gradient that goes from transparent -> dark
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,       // Haut → totalement transparent
                            Colors.black.withOpacity(0.4),
                            Colors.black.withOpacity(0.6),
                            Colors.black.withOpacity(0.8), // Bas → plus opaque
                          ],
                          stops: const [0.0, 0.4, 0.7, 1.0],
                        )
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // fullname and age - single line, ellipsis if too long
                            ShimmerEffect(width: 80.hw, height: 20.hw),
                            const SizedBox(height: 6),
                            // bio - allow up to 2 lines then ellipsis
                            ShimmerEffect(width: 70.hw, height: 20.hw),
                          ],
                        ),

                        SizedBox(width: screenWidth * 0.06),
                        SizedBox(
                          width: screenWidth * 0.25,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ShimmerEffect(width: 40.hw, height: 40.hw),
                              ShimmerEffect(width: 40.hw, height: 40.hw),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
