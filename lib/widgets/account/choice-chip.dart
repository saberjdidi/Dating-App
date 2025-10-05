import 'package:dating_app_bilhalal/core/app_export.dart';
import 'package:dating_app_bilhalal/core/utils/helpers/helper_functions.dart';
import 'package:dating_app_bilhalal/widgets/circular_container.dart';
import 'package:flutter/material.dart';

class TChoiceChip extends StatelessWidget {
  const TChoiceChip({
    super.key,
    required this.text,
    this.size = 30,
    required this.selected,
    this.onSelected
  });

  final String text;
  final double size;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = THelperFunctions.getColor(text) != null;

    return SizedBox(
      width: size + 6, // assure une taille constante
      height: size + 6,
      child: ChoiceChip(
        label: isColor ? const SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? Colors.white : null),

        avatar: isColor
            ? CircularContainer(width: size, height: size, radius: size, backgroundColor: THelperFunctions.getColor(text)!)
            : null,
        /*
        avatar: CircleAvatar(
          backgroundColor: THelperFunctions.getColor(text)!,
        ),
        */
        shape: isColor ? const CircleBorder() : null,
        labelPadding: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
      ),
    );

    /*
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor ? const SizedBox() : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? Colors.white : null),

        avatar: isColor
            ? CircularContainer(width: size, height: size, radius: size, backgroundColor: THelperFunctions.getColor(text)!)
            : null,
        /*
        avatar: CircleAvatar(
          backgroundColor: THelperFunctions.getColor(text)!,
        ),
        */
        shape: isColor ? const CircleBorder() : null,
        labelPadding: isColor ? const EdgeInsets.all(0) : null,
        padding: isColor ? const EdgeInsets.all(0) : null,
        backgroundColor: isColor ? THelperFunctions.getColor(text)! : null,
      ),
    );
     */
  }
}