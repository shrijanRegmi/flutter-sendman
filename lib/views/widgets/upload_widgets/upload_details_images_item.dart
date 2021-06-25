import 'dart:io';

import 'package:flutter/material.dart';
import 'package:send_man/utils/app_colors.dart';
import 'package:send_man/views/widgets/common_widgets/round_icon_button.dart';

class UploadDetailsImageItem extends StatelessWidget {
  final File imgFile;
  final Function(File) onDelete;
  final bool? isLast;
  const UploadDetailsImageItem({
    Key? key,
    required this.imgFile,
    required this.onDelete,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.0,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Container(
          decoration: BoxDecoration(
            color: kcLightOrangeColor,
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: FileImage(imgFile),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.all(10.0),
          child: isLast!
              ? Container()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RoundIconButton(
                          onPressed: () => onDelete(imgFile),
                          padding: const EdgeInsets.all(7.0),
                          shadow: BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10.0,
                          ),
                          icon: Icon(
                            Icons.delete_outline_rounded,
                            size: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
