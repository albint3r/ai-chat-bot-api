import 'package:flutter/material.dart';

class TextBody extends StatelessWidget {
  const TextBody(this.text, {
    this.color,
    this.fontSize,
    this.textAlign,
  });

  final String text;
  final Color? color;
  final double? fontSize;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      text,
      textAlign: textAlign,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: color,
        fontSize: fontSize,
      ),
    );
  }
}
