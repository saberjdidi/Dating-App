import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/discussion_screen/controller/discussion_details_controller.dart';
import 'package:dating_app_bilhalal/widgets/app_bar/appbar_widget.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
import 'package:flutter/material.dart';

class DiscussionDetailsScreen extends GetView<DiscussionDetailsController> {
  const DiscussionDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenheight = mediaQueryData.size.height;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return Scaffold(
      backgroundColor: TColors.white,
      appBar: TAppBar(
        leadingWidth: 180.adaptSize,
        leading: Row(
          children: [
            CircularContainer(
              width: 60.adaptSize,
              height: 60.adaptSize,
              radius: 60.adaptSize,
              backgroundColor: TColors.greyDating.withOpacity(0.6),
              child: IconButton(
                icon: Icon(Icons.call, color: TColors.black.withOpacity(0.7), size: 35.adaptSize,),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(width: 10.adaptSize,),
            CircularContainer(
              width: 60.adaptSize,
              height: 60.adaptSize,
              radius: 60.adaptSize,
              backgroundColor: TColors.greyDating.withOpacity(0.6),
              child: IconButton(
                icon: Icon(Icons.video_call_outlined, color: TColors.black.withOpacity(0.7), size: 35.adaptSize,),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            )
          ],
        ),
        title: Text(controller.userChatModel.fullName,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: TColors.black,
            fontSize: 22.fSize,
            fontWeight: FontWeight.bold,
            //decoration: TextDecoration.underline,
            decorationColor: TColors.black,
          ),
        ),
        actions: [
          CircularContainer(
            width: 60.adaptSize,
            height: 60.adaptSize,
            radius: 60.adaptSize,
            backgroundColor: TColors.greyDating.withOpacity(0.6),
            child: IconButton(
              icon: Icon(Icons.arrow_forward_outlined, color: TColors.black.withOpacity(0.7), size: 35.adaptSize,),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}