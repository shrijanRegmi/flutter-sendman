import 'package:flutter/material.dart';

class WrapperBuilder extends StatelessWidget {
  final Function(BuildContext) builder;
  const WrapperBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return builder(context);
  }
}
