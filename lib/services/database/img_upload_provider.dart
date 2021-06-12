import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:send_man/models/image_upload_model.dart';
import 'package:send_man/services/database/collections.dart';
import 'package:send_man/services/storage/storage_provider.dart';

class ImgUploadProvider {
  final ImgUpload imgUpload;
  ImgUploadProvider({required this.imgUpload});

  final _ref = FirebaseFirestore.instance;

  // save img url to firestore
  Future<ImgUpload?> storeImgUrl(final File imgFile) async {
    try {
      final _coreImagesRef = _ref.collection(coreImagesCol).doc();

      final _imgUrl = await StorageProvider(
              imgFile: imgFile, path: '$coreImagesCol/${_coreImagesRef.id}')
          .uploadFile();

      final _imgUpload = imgUpload.copyWith(
        id: _coreImagesRef.id,
        imgUrl: _imgUrl,
        updatedAt: DateTime.now().millisecondsSinceEpoch,
      );

      await _coreImagesRef.set(_imgUpload.toJson());
      print('Success: Saving image urls to firestore');

      return _imgUpload;
    } catch (e) {
      print(e);
      print('Error!!!: Saving image urls to firestore');
      return null;
    }
  }
}
