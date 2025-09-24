import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/call_screen/controller/call_controller.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class CallScreen extends GetView<CallController> {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var screenheight = mediaQueryData.size.height;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return SafeArea(
      child: Material(
        type: MaterialType.transparency,
        child: Stack(
          children: [
            CustomImageView(
              imagePath: ImageConstant.profile6,
              width: screenWidth,
              height: screenheight,
            ),

            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                  padding: EdgeInsets.only(top: 40.v, right: 20.v, left: 20.v),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: false,
                      child: CircularContainer(
                        width: 60.adaptSize,
                        height: 60.adaptSize,
                        radius: 60.adaptSize,
                        backgroundColor: TColors.greyDating.withOpacity(0.6),
                        child: IconButton(
                          icon: Icon(Icons.camera_alt_outlined, color: TColors.black.withOpacity(0.7), size: 30.adaptSize,),
                          onPressed: (){
                          },
                        ),
                      ),
                    ),
                    TitleWidget(title: "نورا خالد", textAlign: TextAlign.center,),
                    CustomImageView(
                      imagePath: ImageConstant.imgBack,
                      width: 60.adaptSize,
                      height: 60.adaptSize,
                      radius: BorderRadius.circular(60.adaptSize),
                      onTap: (){
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 50.v, right: 20.v, left: 20.v),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Visibility(
                      visible: true,
                      child: CircularContainer(
                        width: 80.adaptSize,
                        height: 80.adaptSize,
                        radius: 80.adaptSize,
                        backgroundColor: TColors.redAppLight,
                        child: IconButton(
                          icon: Icon(Icons.call_end, color: TColors.white, size: 40.adaptSize,),
                          onPressed: (){
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: true,
                      child: CircularContainer(
                        width: 80.adaptSize,
                        height: 80.adaptSize,
                        radius: 80.adaptSize,
                        backgroundColor: TColors.greenAccept,
                        child: IconButton(
                          icon: Icon(Icons.videocam_rounded, color: TColors.white, size: 40.adaptSize,),
                          onPressed: (){
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 130.adaptSize,
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgCallEffect,
                            width: 60.adaptSize,
                            height: 60.adaptSize,
                            radius: BorderRadius.circular(60.adaptSize),
                            onTap: (){

                            },
                          ),
                          SizedBox(height: 9.adaptSize,),
                          CustomImageView(
                            imagePath: ImageConstant.imgCallEffect1,
                            width: 60.adaptSize,
                            height: 60.adaptSize,
                            radius: BorderRadius.circular(60.adaptSize),
                            onTap: (){

                            },
                          ),
                        ],
                      ),
                    )
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
