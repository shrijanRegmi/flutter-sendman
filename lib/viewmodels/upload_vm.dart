import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:send_man/models/image_upload_model.dart';
import 'package:send_man/services/database/img_upload_provider.dart';

class UploadVM extends ChangeNotifier {
  final BuildContext context;
  UploadVM(this.context);

  late File _imgFile;

  File get imgFile => _imgFile;
  List<CoreImage>? get coreImagesList => Provider.of<List<CoreImage>?>(context);
  List<CoreImage>? get todayImages => coreImagesList
      ?.where((element) => checkDate(
          DateTime.fromMillisecondsSinceEpoch(element.updatedAt ?? 0)))
      .toList();
  List<CoreImage>? get otherImages => coreImagesList
      ?.where((element) => !checkDate(
          DateTime.fromMillisecondsSinceEpoch(element.updatedAt ?? 0)))
      .toList();

  // get image from gallery
  void getImgFromGallery() async {
    final _pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      _imgFile = File(_pickedFile.path);
      uploadImage();
    }

    notifyListeners();
  }

  // upload image to firebase
  void uploadImage() async {
    await ImgUploadProvider().storeImgUrl(imgFile);
  }

  // check if given date is today or not
  bool checkDate(final DateTime date) {
    final _now = DateTime.now();

    return date.year == _now.year &&
        date.month == _now.month &&
        date.day == _now.day;
  }
}
