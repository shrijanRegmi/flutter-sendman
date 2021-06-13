import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:send_man/models/image_upload_model.dart';
import 'package:send_man/services/database/collections.dart';
import 'package:send_man/services/storage/storage_provider.dart';

class ImgUploadProvider {
  final _ref = FirebaseFirestore.instance;

  // save img url to firestore
  Future<ImgUpload?> storeImgUrl(final File imgFile) async {
    try {
      final _coreImagesRef = _ref.collection(coreImagesCol).doc();

      final _imgUrl = await StorageProvider(
              imgFile: imgFile, path: '$coreImagesCol/${_coreImagesRef.id}')
          .uploadFile();

      final _imgUpload = ImgUpload(
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

  // get images from firestore
  List<ImgUpload> _imgUploadFromFirebase(
      final QuerySnapshot<Map<String, dynamic>> colSnap) {
    return colSnap.docs.map((e) => ImgUpload.fromJson(e.data())).toList();
  }

  // stream of images
  Stream<List<ImgUpload>> get coreImagesStream {
    return _ref
        .collection(coreImagesCol)
        .snapshots()
        .map(_imgUploadFromFirebase);
  }
}
