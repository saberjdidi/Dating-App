import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/UserModel.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
import 'package:dating_app_bilhalal/widgets/gradient/gradient_svg_icon.dart';
import 'package:dating_app_bilhalal/widgets/home/favorite_icon.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class UserCardWidget extends StatelessWidget {
  final UserModel user;
  final VoidCallback onMessageTap;
  final VoidCallback onFavoriteTap;
  VoidCallback? onTapFilter;

   UserCardWidget({
    Key? key,
    required this.user,
    required this.onMessageTap,
    required this.onFavoriteTap,
    this.onTapFilter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenHeight = mediaQueryData.size.height;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;
    // small helpers for consistent sizing
    const double iconSize = 28;
    const double bottomPadding = 12;
    const double horizontalPadding = 12;

    return ClipRRect(
      borderRadius: BorderRadius.zero, // ✅ enlève coins arrondis du Card
      child: Stack(
        children: [
          // background image (fills)
          Positioned.fill(
            child: CustomImageView(
              imagePath: user.imageProfile,
              //height: screenHeight,
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
        /*  Positioned.fill(
            child: Image.network(
              user.imageProfile,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder: (context, error, stack) =>
                  Container(color: Colors.grey.shade300),
            ),
          ), */

          // Image en haut à droite
        /*  Positioned(
              top: 20,
              right: 20,
              child: CircularContainer(
                width: 60.adaptSize,
                height: 60.adaptSize,
                radius: 60.adaptSize,
                backgroundColor: TColors.greyDating.withOpacity(1),
                child: IconButton(
                  icon: Icon(Icons.filter_alt_outlined, color: TColors.black54, size: 35.adaptSize,),
                  onPressed: onTapFilter,
                ),
              )
          ), */
         // 🔥 Dégradé progressif noir transparent vers noir
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.3, // effet plus grand
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
                          width: screenWidth * 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: onMessageTap,
                                child: GradientSvgIcon(
                                  assetPath: ImageConstant.iconChat,
                                  size:  isTablet ? 48.adaptSize : 42.adaptSize,
                                  gradient: const LinearGradient(
                                    colors: [TColors.primaryColorApp, TColors.primaryColorApp],
                                    //colors: [Color(0xFFFFFC00), Color(0xFFFFFC00)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.hw,),
                              FavoriteIcon(userId: "1"),
                             /* GestureDetector(
                                onTap: onFavoriteTap,
                                child: GradientSvgIcon(
                                  assetPath: ImageConstant.iconLove,
                                  size: isTablet ? 55.adaptSize : 38.adaptSize,
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFFF40303), Color(0xFF8E0202)],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                              ), */
                              /*  CustomImageView(
                          imagePath: ImageConstant.iconChat,
                          height: 45.hw,
                          width: 45.hw,
                          //fit: BoxFit.cover,
                          onTap: onMessageTap,
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.iconLove,
                          height: 45.hw,
                          width: 45.hw,
                          //fit: BoxFit.cover,
                          color: Color(0xECA90606),
                          onTap: onFavoriteTap,
                        ), */
                            ],
                          ),
                        ),

                        SizedBox(width: screenWidth * 0.1),

                        // --- Infos utilisateur
                        // Right side: text info - put into Expanded/Flexible so it can't overflow the row
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // fullname and age - single line, ellipsis if too long
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${user.fullName}، ${user.age}',
                                    textAlign: TextAlign.right,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: isTablet ? 30.adaptSize : 26.adaptSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 5.adaptSize),
                                  CircleAvatar(radius: 6, backgroundColor: Colors.green)
                                ],
                              ),

                              const SizedBox(height: 6),
                              // bio - allow up to 2 lines then ellipsis
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    user.bio,
                                    textAlign: TextAlign.right,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(width: 10.adaptSize),
                                  CustomImageView(
                                    imagePath: ImageConstant.iconJob,
                                    color: Colors.white70,
                                    //height: 200.adaptSize,
                                    //width: 200.adaptSize,
                                    fit: BoxFit.cover,
                                  ),
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
        ],
      ),
    );
  }
}

/*
class UserCardWidget extends StatelessWidget {
  final UserModel user;
  final VoidCallback onMessageTap;
  final VoidCallback onFavoriteTap;
  VoidCallback? onTapFilter;

  UserCardWidget({
    Key? key,
    required this.user,
    required this.onMessageTap,
    required this.onFavoriteTap,
    this.onTapFilter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenHeight = mediaQueryData.size.height;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;
    // small helpers for consistent sizing
    const double iconSize = 28;
    const double bottomPadding = 12;
    const double horizontalPadding = 12;

    return ClipRRect(
      borderRadius: BorderRadius.zero, // ✅ enlève coins arrondis du Card
      child: Stack(
        children: [
          // background image (fills)
          Positioned.fill(
            child: CustomImageView(
              imagePath: user.imageProfile,
              //height: screenHeight,
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

          // bottom info container with gradient to improve readability
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: screenHeight * 0.15,
              padding: const EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: bottomPadding,
              ),
              // Use a subtle gradient that goes from transparent -> dark
               decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(1),
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left side: fixed-size vertical icon column
                  SizedBox(
                    width: screenWidth * 0.3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                        SizedBox(width: 10.hw,),
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
                      ],
                    ),
                  ),

                  SizedBox(width: screenWidth * 0.1),

                  // Right side: text info - put into Expanded/Flexible so it can't overflow the row
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // fullname and age - single line, ellipsis if too long
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${user.fullName}، ${user.age}',
                              textAlign: TextAlign.right,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: isTablet ? 30.adaptSize : 26.adaptSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5.adaptSize),
                            CircleAvatar(radius: 6, backgroundColor: Colors.green)
                          ],
                        ),

                        const SizedBox(height: 6),
                        // bio - allow up to 2 lines then ellipsis
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              user.bio,
                              textAlign: TextAlign.right,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(width: 10.adaptSize),
                            CustomImageView(
                              imagePath: ImageConstant.iconJob,
                              color: Colors.white70,
                              //height: 200.adaptSize,
                              //width: 200.adaptSize,
                              fit: BoxFit.cover,
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/