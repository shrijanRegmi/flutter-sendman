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
  List<ImgUpload>? get coreImagesList => Provider.of<List<ImgUpload>?>(context);

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
}
