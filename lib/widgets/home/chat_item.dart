
import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/data/models/user_chat_model.dart';
import 'package:dating_app_bilhalal/widgets/rounded_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ChatItem extends StatelessWidget {
  final UserChatModel chat;
  final VoidCallback? onTap;

  const ChatItem({super.key, required this.chat, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Slidable(
        key: const ValueKey(0),
        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
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
        ),
        endActionPane: ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              // An action can be bigger than the others.
              flex: 2,
              onPressed: (context) {
              },
              backgroundColor: TColors.redAppLight,
              foregroundColor: Colors.white,
              icon: Iconsax.trash,
              label: '',
              borderRadius: BorderRadius.circular(10.adaptSize),
            ),
          ],
        ),
        child: TRoundedContainer(
          borderColor: TColors.greyDating,
          showBorder: true,
          padding: EdgeInsets.symmetric(horizontal: TSizes.spaceBtwItems.hw, vertical: TSizes.spaceBtwItems.v),
          margin: EdgeInsets.symmetric(vertical: 10.v, horizontal: 10.hw),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 28,
                   /* backgroundImage: CustomImageView(
                      imagePath: ImageConstant.uploadImageRounded,
                      //height: 50.adaptSize,
                      //width: 50.adaptSize,
                      fit: BoxFit.fill,
                    ),*/
                    backgroundImage: AssetImage(chat.file!), // Remplacer par chat.file si image
                  ),
                  if (chat.isConnect)
                    Positioned(
                      right: 0,
                      top: 0,
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
                    Text(chat.fullName, style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(
                      chat.lastMessage,
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