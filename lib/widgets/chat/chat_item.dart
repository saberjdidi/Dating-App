
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/chat_model.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ChatItem extends StatelessWidget {
  final ChatModel chat;
  final VoidCallback? onTap;

  const ChatItem({super.key, required this.chat, this.onTap});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return InkWell(
      onTap: onTap,
      child: Slidable(
        key: const ValueKey(0),
        // The start action pane is the one at the left or the top side.
       /* startActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // All actions are defined in the children parameter.
          children: [
            SlidableAction(
              onPressed: (context) {

              },
              backgroundColor: Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              //icon: Icons.list,
              label: 'Details',
            ),
          ],
        ), */
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TRoundedContainer(
                  width: 50.hw,
                  height: 50.hw,
                  radius: 10.hw,
                  backgroundColor: TColors.redAppLight,
                  child: Icon(Iconsax.trash, size: 25.hw, color: TColors.light,),
                ),
                SizedBox(width: 10.hw,),
                TRoundedContainer(
                  width: 50.hw,
                  height: 50.hw,
                  radius: 10.hw,
                  backgroundColor: Color(0xFFF4AB03),
                  child: Icon(Iconsax.archive_11, size: 25.hw, color: TColors.light),
                ),
              ],
            ),
           /* SlidableAction(
              // An action can be bigger than the others.
              flex: 1,
              onPressed: (context) {
              },
              backgroundColor: TColors.redAppLight,
              foregroundColor: Colors.white,
              icon: Iconsax.trash,
              label: '',
              borderRadius: BorderRadius.circular(10.adaptSize),
            ),
            SlidableAction(
              // An action can be bigger than the others.
              flex: 1,
              onPressed: (context) {
              },
              backgroundColor: Color(0xFFF4AB03),
              foregroundColor: Colors.white,
              icon: Iconsax.archive_11,
              label: '',
              borderRadius: BorderRadius.circular(10.adaptSize),
            ), */
          ],
        ),
        child: TRoundedContainer(
          borderColor: TColors.buttonSecondary,
          backgroundColor: TColors.greyContainerChat,
          withBorder: 0.7,
          showBorder: true,
          padding: EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems.hw, vertical: 8.v),
          margin: EdgeInsets.symmetric(vertical: 5.v, horizontal: 10.hw),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: isSmallPhone ? 22 : 28,
                   /* backgroundImage: CustomImageView(
                      imagePath: ImageConstant.uploadImageRounded,
                      //height: 50.adaptSize,
                      //width: 50.adaptSize,
                      fit: BoxFit.fill,
                    ),*/
                    backgroundImage: AssetImage(chat.senderProfile!), // Remplacer par chat.file si image
                  ),
                  if (chat.isConnect)
                    Positioned(
                      right: 2,
                      top: 2,
                      child: CircleAvatar(
                        radius: 6,
                        backgroundColor: Colors.green,
                      ),
                    )
                ],
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(chat.senderFullName!, style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(
                      chat.recentTextMessage,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Text(
                chat.timeAgo(),
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}