import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:send_man/helpers/date_time_helper.dart';
import 'package:send_man/models/core_img_model.dart';
import 'package:send_man/services/database/collections.dart';
import 'package:send_man/services/storage/storage_provider.dart';
import 'package:send_man/utils/variables.dart';
import 'package:send_man/viewmodels/progress_status_vm.dart';
import 'package:share/share.dart';

class ImgUploadProvider {
  final String? uid;
  ImgUploadProvider({this.uid});

  final _ref = FirebaseFirestore.instance;

  // save img url to firestore
  Future<CoreImage?> uploadCoreImg(
    final ProgressStatusVM uploadStatusVm,
    final List<File> imgFiles,
    final DateTime disDate,
    final TimeOfDay disTime,
  ) async {
    try {
      final _coreImagesRef = _ref.collection(coreImagesCol).doc();
      final _imgs = <String>[];
      Fluttertoast.showToast(msg: 'Upload started...');
      final _updatedAt = DateTime.now().millisecondsSinceEpoch;

      for (int i = 0; i < imgFiles.length; i++) {
        final _path =
            '$coreImagesCol/${_coreImagesRef.id}/${_updatedAt}_${_coreImagesRef.id}_${i + 1}';

        await Future.delayed(Duration(milliseconds: 2000));
        uploadStatusVm.updateUploadProgress(0.0);
        uploadStatusVm.updateUploadedImgCount(i + 1);

        final _imgUrl = await StorageProvider(
          imgFile: imgFiles[i],
          path: _path,
          onProgressUpdate: (progress) {
            uploadStatusVm.updateUploadProgress(progress);
          },
        ).uploadFile();

        _imgs.add(_imgUrl);
      }

      final _coreImg = CoreImage(
        uid: uid,
        id: _coreImagesRef.id,
        imgUrls: _imgs,
        disDate: disDate
            .add(Duration(hours: disTime.hour, minutes: disTime.minute))
            .millisecondsSinceEpoch,
        disTime: DateTimeHelper().getFormattedTime(disTime),
        updatedAt: _updatedAt,
      );

      await _coreImagesRef.set(_coreImg.toJson());
      await Future.delayed(Duration(milliseconds: 2000));
      uploadStatusVm.completeUpload();
      Fluttertoast.showToast(msg: 'Uploaded successfully');

      print('Success: Saving image urls to firestore');
      return _coreImg;
    } catch (e) {
      print(e);
      print('Error!!!: Saving image urls to firestore');
      uploadStatusVm.completeUpload();
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
      await Fluttertoast.showToast(msg: 'Deleted Successfully');
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

  // get single image from url
  Future<CoreImage?> getSingleImageFromUrl(final String url) async {
    try {
      final _id = url.replaceAll('$kWebLink/', '');
      final _coreImgRef = _ref.collection('core_images').doc(_id);
      final _coreImgSnap = await _coreImgRef.get();

      if (_coreImgSnap.exists) {
        final _data = _coreImgSnap.data();

        if (_data != null) {
          final _coreImg = CoreImage.fromJson(_data);

          print("Success: Getting image from url $url");
          return _coreImg;
        }
      }
    } catch (e) {
      print(e);
      print("Error!!!: Getting image from url $url");
      return null;
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
        .where('uid', isEqualTo: uid)
        .orderBy('updated_at', descending: true)
        .limit(20)
        .snapshots()
        .map(_imgUploadFromFirebase);
  }
}
