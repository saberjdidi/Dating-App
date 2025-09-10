import 'package:flutter/material.dart';

class CustomDividerWidget extends StatelessWidget {
  const CustomDividerWidget({
    super.key,
    this.height = 1.0,
    this.thickness = 1.0,
  });

  final double height;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height,
      color: Colors.grey,
      thickness: thickness,
    );
  }
}