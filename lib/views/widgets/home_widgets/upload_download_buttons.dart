import 'dart:math';

import 'package:flutter/material.dart';
import 'package:send_man/utils/app_colors.dart';
import 'package:send_man/views/screens/upload_screen.dart';
import 'package:send_man/views/widgets/common_widgets/round_icon_button.dart';
import 'package:send_man/views/widgets/common_widgets/text_builder.dart';

class UploadDownloadButtons extends StatelessWidget {
  const UploadDownloadButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buttonBuilder(
            'Upload',
            kcLightOrangeColor,
            Colors.deepOrange.withOpacity(0.3),
            Icons.keyboard_arrow_up,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UploadScreen(),
                ),
              );
            },
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: _buttonBuilder(
            'Download',
            kcLightPurpleColor,
            Colors.deepPurple.withOpacity(0.3),
            Icons.keyboard_arrow_down,
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UploadScreen(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buttonBuilder(
    final String text,
    final Color color,
    final Color shadowColor,
    final IconData icon,
    final Function() onPressed,
  ) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Transform.rotate(
                    angle: pi / 180 * 30,
                    child: RoundIconButton(
                      onPressed: onPressed,
                      icon: Icon(icon),
                      shadow: BoxShadow(
                        color: shadowColor,
                        blurRadius: 20.0,
                        offset: Offset(5.0, 10.0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              TextBuilder.heading3(text),
            ],
          ),
        ),
        Positioned(
          right: 0.0,
          bottom: 0.0,
          child: Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.2),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
