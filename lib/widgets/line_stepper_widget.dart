import 'package:flutter/material.dart';

class LineStepperWidget extends StatelessWidget {
  final int stepCount;
  final int activeStep; // 0..stepCount-1 (0 = première étape, qui sera affichée à droite)
  final ValueChanged<int>? onStepTapped;
  final double dotRadius;
  final double spacing;
  final Color activeColor;
  final Color inactiveColor;
  final double connectorHeight;
  final double connectorWidth; // default width between dots

  const LineStepperWidget({
    Key? key,
    required this.stepCount,
    required this.activeStep,
    this.onStepTapped,
    this.dotRadius = 8,
    this.spacing = 5,
    this.activeColor = Colors.black,
    this.inactiveColor = Colors.grey,
    this.connectorHeight = 8,
    this.connectorWidth = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (stepCount <= 0) return const SizedBox.shrink();

    // Build children in logical order (0..n-1) but Row will use RTL direction
    final List<Widget> children = [];
    for (int i = 0; i < stepCount; i++) {
      final bool isCompleted = i <= activeStep;

      // Dot
      children.add(GestureDetector(
        onTap: () {
          if (onStepTapped != null) onStepTapped!(i);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: dotRadius * 3,
          height: dotRadius * 1,
          decoration: BoxDecoration(
            color: isCompleted ? activeColor : inactiveColor,
            shape: BoxShape.rectangle,
            //shape: BoxShape.circle,
            boxShadow: isCompleted
                ? [BoxShadow(color: activeColor.withOpacity(0.25), blurRadius: 6, offset: const Offset(0,2))]
                : [],
          ),
        ),
      ));

      // Connector (do not add after last dot)
      if (i != stepCount - 1) {
        children.add(SizedBox(width: spacing / 2));
        // connector is a line whose color depends on the left-side dot's completion.
        final bool connectorActive = i < activeStep; // connector between i and i+1 "active" if i < activeStep
        children.add(AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: connectorWidth,
          height: connectorHeight,
          decoration: BoxDecoration(
            color: connectorActive ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(connectorHeight),
          ),
        ));
        children.add(SizedBox(width: spacing / 2));
      }
    }

    // Use Row with RTL so the first child (index 0) is displayed at the rightmost position.
    return Row(
      mainAxisSize: MainAxisSize.min,
      textDirection: TextDirection.rtl,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}
