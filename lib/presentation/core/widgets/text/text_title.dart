import 'package:flutter/material.dart';

import 'title_type.dart';

class TextTitle extends StatelessWidget {
  const TextTitle(
    this.text, {
    required this.titleType,
    this.color,
    this.textAlign,
  });

  factory TextTitle.h1(
    String text, {
    TextAlign? textAlign,
    Color? color,
  }) =>
      TextTitle(
        text,
        titleType: TitleType.h1,
        color: color,
        textAlign: textAlign,
      );

  factory TextTitle.h2(
    String text, {
    TextAlign? textAlign,
    Color? color,
  }) =>
      TextTitle(
        text,
        titleType: TitleType.h2,
        color: color,
        textAlign: textAlign,
      );

  factory TextTitle.h3(
    String text, {
    TextAlign? textAlign,
    Color? color,
  }) =>
      TextTitle(
        text,
        titleType: TitleType.h3,
        color: color,
        textAlign: textAlign,
      );

  final String text;
  final TitleType titleType;
  final Color? color;
  final TextAlign? textAlign;

  TextStyle? _getTextStyle(TextTheme textTheme) {
    switch (titleType) {
      case (TitleType.h1):
        {
          return textTheme.titleLarge;
        }
      case (TitleType.h2):
        {
          return textTheme.titleMedium;
        }
      case (TitleType.h3):
        {
          return textTheme.titleSmall;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final textStyle = _getTextStyle(textTheme);

    return Text(
      text,
      textAlign: textAlign,
      style: textStyle?.copyWith(
        color: color,
      ),
    );
  }
}
