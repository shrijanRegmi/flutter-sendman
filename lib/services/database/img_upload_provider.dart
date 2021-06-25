import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:send_man/helpers/date_time_helper.dart';
import 'package:send_man/models/core_img_model.dart';
import 'package:send_man/services/database/collections.dart';
import 'package:send_man/services/storage/storage_provider.dart';
import 'package:send_man/utils/variables.dart';
import 'package:share/share.dart';

class ImgUploadProvider {
  final _ref = FirebaseFirestore.instance;

  // save img url to firestore
  Future<CoreImage?> uploadCoreImg(
    final List<File> imgFiles,
    final DateTime disDate,
    final TimeOfDay disTime,
  ) async {
    try {
      final _coreImagesRef = _ref.collection(coreImagesCol).doc();
      final _imgs = <String>[];

      for (int i = 0; i < imgFiles.length; i++) {
        final _imgUrl = await StorageProvider(
          imgFile: imgFiles[i],
          path:
              '$coreImagesCol/${_coreImagesRef.id}/${DateTime.now().millisecondsSinceEpoch}_${_coreImagesRef.id}',
        ).uploadFile();

        _imgs.add(_imgUrl);
      }

      final _coreImg = CoreImage(
        id: _coreImagesRef.id,
        imgUrls: _imgs,
        disDate: disDate.millisecondsSinceEpoch,
        disTime: DateTimeHelper().getFormattedTime(disTime),
        updatedAt: DateTime.now().millisecondsSinceEpoch,
      );

      await _coreImagesRef.set(_coreImg.toJson());
      print('Success: Saving image urls to firestore');

      return _coreImg;
    } catch (e) {
      print(e);
      print('Error!!!: Saving image urls to firestore');
      return null;
    }
  }

  // delete img
  Future deleteImg(final CoreImage coreImg, final String imgUrl) async {
    try {
      final _coreImgRef = _ref.collection('core_images').doc(coreImg.id);

      if ((coreImg.imgUrls ?? []).length == 1) {
        await _coreImgRef.delete();
      } else {
        await _coreImgRef.update({
          'image_urls': FieldValue.arrayRemove([imgUrl])
        });
      }

      print('Success: Deleting img $imgUrl');
      return 'Success';
    } catch (e) {
      print(e);
      print('Error!!!: Deleting img $imgUrl');
      return null;
    }
  }

  // download image
  Future downloadImage(final String imgUrl) async {
    try {
      return await ImageDownloader.downloadImage(imgUrl);
    } catch (e) {
      print(e);
      print("Error!!!: Downloading Image");
    }
  }

  // share image link
  Future<void> shareImage(final String id) async {
    try {
      await Share.share('$kWebLink/$id');
    } catch (e) {
      print(e);
      print("Error!!!: Sharing Image");
    }
  }

  // get images from firestore
  List<CoreImage> _imgUploadFromFirebase(
      final QuerySnapshot<Map<String, dynamic>> colSnap) {
    return colSnap.docs.map((e) => CoreImage.fromJson(e.data())).toList();
  }

  // stream of images
  Stream<List<CoreImage>> get coreImagesStream {
    return _ref
        .collection(coreImagesCol)
        .orderBy('updated_at', descending: true)
        .limit(20)
        .snapshots()
        .map(_imgUploadFromFirebase);
  }
}
