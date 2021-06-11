import 'package:flutter/material.dart';

class RoundIconButton extends StatelessWidget {
  final Widget icon;
  final EdgeInsetsGeometry? padding;
  final Color? bgColor;
  final BoxShadow? shadow;
  final Function()? onPressed;
  const RoundIconButton({
    Key? key,
    required this.icon,
    this.bgColor = Colors.white,
    this.padding,
    this.shadow,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor,
          boxShadow: [
            shadow ??
                BoxShadow(
                  color: Colors.transparent,
                )
          ],
        ),
        padding: padding ?? const EdgeInsets.all(10.0),
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}
