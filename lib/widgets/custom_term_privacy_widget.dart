import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/widgets/title_widget.dart';
import 'package:flutter/material.dart';

class CustomTermPrivacyWidget extends StatelessWidget {
  CustomTermPrivacyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: (){

          },
          child: Text("شروط الاستخدام",
              style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.black, fontWeightDelta: 2),
              textAlign: TextAlign.center),
        ),
        InkWell(
          onTap: (){

          },
          child: Text("سياسة الخصوصية",
              style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.black, fontWeightDelta: 2),
              textAlign: TextAlign.center),
        ),
      ],
    );
  }
}