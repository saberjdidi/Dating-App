import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:flutter/material.dart';

class CountDownWidget extends AnimatedWidget {
  final Animation<int> animation;
  var _appTheme = PrefUtils.getTheme();

  CountDownWidget({
    Key? key,
    required this.animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);
    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}s';

    // Convertir en minutes et secondes
   /* int totalSeconds = animation.value;
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    // Formater comme "1:10"
    String timerText = '$minutes:${seconds.toString().padLeft(2, '0')}s';
    */

    return Text(
      timerText,
      style: TextStyle(
        color: _appTheme =='light' ? TColors.gray700 : TColors.white, // ✅ Noir
        fontSize: 25.adaptSize,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
