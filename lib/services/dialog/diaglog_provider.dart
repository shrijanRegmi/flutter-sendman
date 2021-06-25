import 'package:flutter/material.dart';
import 'package:send_man/views/widgets/common_widgets/text_builder.dart';

class DialogProvider {
  final BuildContext context;
  DialogProvider(this.context);

  Future showConfirmationDialog(
    final String title,
    final String body, {
    final Function()? onPressedPositive,
    final Function()? onPressedNegative,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$title'),
        content: TextBuilder.body(
          body,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              if (onPressedNegative != null) onPressedNegative();
            },
            icon: Icon(
              Icons.close,
            ),
            splashRadius: 25.0,
          ),
          SizedBox(
            width: 5.0,
          ),
          IconButton(
            splashRadius: 25.0,
            onPressed: () {
              Navigator.pop(context);
              if (onPressedPositive != null) onPressedPositive();
            },
            icon: Icon(
              Icons.check,
            ),
          ),
        ],
      ),
    );
  }
}
