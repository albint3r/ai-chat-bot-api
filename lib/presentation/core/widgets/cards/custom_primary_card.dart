import 'package:flutter/material.dart';

import '../../theme/const_values.dart';

class CustomPrimaryCard extends StatelessWidget {
  const CustomPrimaryCard({
    this.child,
    this.height = 65,
    this.width = 350,
  });

  final Widget? child;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(borderRadius),
        ),
        border: Border.all(
          color: colorScheme.onBackground,
          width: borderWidth,
        ),
      ),
      child: child,
    );
  }
}
