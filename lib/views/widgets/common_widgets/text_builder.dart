import 'package:flutter/material.dart';
import 'package:send_man/utils/app_styles.dart';

class TextBuilder extends StatelessWidget {
  final String value;
  final TextStyle defaultStyle;
  final TextStyle? style;
  final TextAlign? textAlign;

  const TextBuilder.heading1(
    this.value, {
    this.style,
    this.textAlign,
  }) : defaultStyle = headingText1;
  const TextBuilder.heading2(
    this.value, {
    this.style,
    this.textAlign,
  }) : defaultStyle = headingText2;
  const TextBuilder.heading3(
    this.value, {
    this.style,
    this.textAlign,
  }) : defaultStyle = headingText3;
  const TextBuilder.heading4(
    this.value, {
    this.style,
    this.textAlign,
  }) : defaultStyle = headingText4;
  const TextBuilder.heading5(
    this.value, {
    this.style,
    this.textAlign,
  }) : defaultStyle = headingText5;
  const TextBuilder.heading6(
    this.value, {
    this.style,
    this.textAlign,
  }) : defaultStyle = headingText6;
  const TextBuilder.body(
    this.value, {
    this.style,
    this.textAlign,
  }) : defaultStyle = bodyText;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: defaultStyle.merge(style),
      textAlign: textAlign,
    );
  }
}
