import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/presentation/terms_privacy_screen/privacy_policy_screen.dart';
import 'package:dating_app_bilhalal/presentation/terms_privacy_screen/termes_condition_screen.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class CustomTermPrivacyWidget extends StatelessWidget {
  CustomTermPrivacyWidget({
    super.key,
  });

  var _appTheme = PrefUtils.getTheme();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    var screenWidth = mediaQueryData.size.width;
    var isSmallPhone = screenWidth < 360;
    var isTablet = screenWidth >= 600;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  TermesAndConditionsScreen()));
          },
          child: Text("شروط الاستخدام",
              style: isTablet
               ? Theme.of(context).textTheme.headlineMedium!.apply(color: _appTheme =='light' ? TColors.black : TColors.white, fontWeightDelta: 2)
               : Theme.of(context).textTheme.bodyLarge!.apply(color: _appTheme =='light' ? TColors.black : TColors.white, fontWeightDelta: 2),
              textAlign: TextAlign.center),
        ),
        InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()));
          },
          child: Text("سياسة الخصوصية",
              style: isTablet
                  ? Theme.of(context).textTheme.headlineMedium!.apply(color: _appTheme =='light' ? TColors.black : TColors.white, fontWeightDelta: 2)
                  : Theme.of(context).textTheme.bodyLarge!.apply(color: _appTheme =='light' ? TColors.black : TColors.white, fontWeightDelta: 2),
              textAlign: TextAlign.center),
        ),
      ],
    );
  }
}