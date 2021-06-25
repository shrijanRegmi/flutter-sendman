import 'dart:io';

import 'package:flutter/material.dart';
import 'package:send_man/views/widgets/upload_widgets/upload_details_images_item.dart';

class UploadDetailsImagesList extends StatelessWidget {
  final List<File> imgFiles;
  final Function(File) onDelete;
  const UploadDetailsImagesList({
    Key? key,
    required this.imgFiles,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240.0,
      child: ListView.builder(
        itemCount: imgFiles.length,
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          final _imgFile = imgFiles[index];
          return UploadDetailsImageItem(
            imgFile: _imgFile,
            onDelete: onDelete,
            isLast: imgFiles.length == 1,
          );
        },
      ),
    );
  }
}
