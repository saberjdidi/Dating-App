import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/UserModel.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
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
                        CustomImageView(
                          imagePath: ImageConstant.imgMessage,
                          height: 60.adaptSize,
                          width: 60.adaptSize,
                          fit: BoxFit.cover,
                          onTap: onMessageTap,
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgFavoris,
                          height: 60.adaptSize,
                          width: 60.adaptSize,
                          fit: BoxFit.cover,
                          onTap: onFavoriteTap,
                        ),
                       /* SizedBox(
                          width: iconSize + 8,
                          height: iconSize + 8,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(Icons.message, color: Colors.white),
                            iconSize: iconSize,
                            onPressed: onMessageTap,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: iconSize + 8,
                          height: iconSize + 8,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            icon: const Icon(Icons.favorite_border, color: Colors.white),
                            iconSize: iconSize,
                            onPressed: onFavoriteTap,
                          ),
                        ), */
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
                        const SizedBox(height: 6),
                        // bio - allow up to 2 lines then ellipsis
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

/*
class UserCardWidget extends StatelessWidget {
  final UserModel user;
  final VoidCallback onMessageTap;
  final VoidCallback onFavoriteTap;

  const UserCardWidget({
    super.key,
    required this.user,
    required this.onMessageTap,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // Image en arrière-plan
          Positioned.fill(
            child: CustomImageView(
              imagePath: user.imageProfile,
              //height: 200.adaptSize,
              //width: 200.adaptSize,
              fit: BoxFit.cover,
            ),
          ),
          // Container en bas
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.black.withOpacity(0.6),
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Icônes gauche : message & favori
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.message, color: Colors.white),
                        onPressed: onMessageTap,
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite, color: Colors.red),
                        onPressed: onFavoriteTap,
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Nom, âge et bio à droite
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${user.fullName}, ${user.age}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        user.bio,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                        textAlign: TextAlign.right,
                      ),
                    ],
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
