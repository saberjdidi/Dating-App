import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/UserModel.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
import 'package:dating_app_bilhalal/widgets/gradient/gradient_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class FavoriteCardWidget extends StatelessWidget {
  final UserModel user;
  final VoidCallback onMessageTap;
  final VoidCallback onFavoriteTap;

  FavoriteCardWidget({
    Key? key,
    required this.user,
    required this.onMessageTap,
    required this.onFavoriteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenheight = mediaQueryData.size.height;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;
    // small helpers for consistent sizing
    const double iconSize = 28;
    const double bottomPadding = 8;
    const double horizontalPadding = 8;

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
              child: CustomImageView(
                imagePath: user.imageProfile,
                //height: 200.adaptSize,
                //width: screenWidth,
                fit: BoxFit.cover,
                onTap: (){
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context) => AnnonceDetailsScreen(model: model)));
                  Get.toNamed(Routes.profileDetailsScreen, arguments: {
                    "UserModel" : user
                  });
                },
              ),
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
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.9),
                    ],
                  ),
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
                        Text(
                          '${user.fullName}، ${user.age}',
                          textAlign: TextAlign.right,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22.adaptSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 6),
                        // bio - allow up to 2 lines then ellipsis
                        Text(
                          user.bio,
                          textAlign: TextAlign.right,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14.adaptSize,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(width: screenWidth * 0.06),
                    SizedBox(
                      width: screenWidth * 0.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: onFavoriteTap,
                            child: GradientSvgIcon(
                              assetPath: ImageConstant.iconLove,
                              size: 38.adaptSize,
                              gradient: const LinearGradient(
                                colors: [Color(0xFFF40303), Color(0xFF8E0202)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: onMessageTap,
                            child: GradientSvgIcon(
                              assetPath: ImageConstant.iconChat,
                              size: 45.adaptSize,
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFFFC00), Color(0xFFFFFC00)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                          ),
                        /*  CustomImageView(
                            imagePath: ImageConstant.imgFavoris,
                            height: 40.adaptSize,
                            width: 40.adaptSize,
                            fit: BoxFit.cover,
                            onTap: onFavoriteTap,
                          ),
                          CustomImageView(
                            imagePath: ImageConstant.imgMessage,
                            height: 40.adaptSize,
                            width: 40.adaptSize,
                            fit: BoxFit.cover,
                            onTap: onMessageTap,
                          ), */
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
  }
}
