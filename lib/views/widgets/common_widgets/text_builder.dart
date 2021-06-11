import 'package:flutter/material.dart';
import 'package:send_man/utils/app_styles.dart';

class TextBuilder extends StatelessWidget {
  final String value;
  final TextStyle defaultStyle;
  final TextStyle? style;

  const TextBuilder.heading1(this.value, {this.style})
      : defaultStyle = headingText1;
  const TextBuilder.heading2(this.value, {this.style})
      : defaultStyle = headingText2;
  const TextBuilder.heading3(this.value, {this.style})
      : defaultStyle = headingText3;
  const TextBuilder.heading4(this.value, {this.style})
      : defaultStyle = headingText4;
  const TextBuilder.heading5(this.value, {this.style})
      : defaultStyle = headingText5;
  const TextBuilder.heading6(this.value, {this.style})
      : defaultStyle = headingText6;
  const TextBuilder.body(this.value, {this.style}) : defaultStyle = bodyText;

  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      style: defaultStyle.merge(style),
    );
  }
}
