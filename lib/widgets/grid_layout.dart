import 'package:flutter/material.dart';
import '../core/app_export.dart';

class GridLayout extends StatelessWidget {
  const GridLayout({
    super.key,
    required this.itemCount,
    this.mainAxisExtent =  255,
    this.crossAxisCount = 3,
    required this.itemBuilder
  });

  final int itemCount;
  final double? mainAxisExtent;
  final int crossAxisCount;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: itemCount,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: TSizes.gridViewSpacing,
            mainAxisSpacing: TSizes.gridViewSpacing,
            mainAxisExtent: mainAxisExtent
        ),
        itemBuilder: itemBuilder
    );
  }
}