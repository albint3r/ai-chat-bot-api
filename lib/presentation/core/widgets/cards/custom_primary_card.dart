import 'package:flutter/material.dart';

import '../../theme/const_values.dart';

class CustomPrimaryCard extends StatelessWidget {
  const CustomPrimaryCard({
    this.child,
    this.height = 65,
    this.width = 350,
    this.onPressed,
  });

  final Widget? child;
  final double height;
  final double width;
  final void Function()? onPressed;

  ButtonStyle _getStyle(ColorScheme colorScheme) {
    return OutlinedButton.styleFrom(
      side: BorderSide(
        color: colorScheme.onSurface,
      ),
      padding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return OutlinedButton(
      onPressed: onPressed,
      style: _getStyle(colorScheme),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: padding,
        ),
        child: SizedBox(
          height: height,
          width: width,
          child: child,
        ),
      ),
    );
  }
}
