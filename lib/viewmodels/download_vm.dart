import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:send_man/models/progress_status_model.dart';
import 'package:send_man/services/ads/ad_provider.dart';
import 'package:send_man/services/database/img_upload_provider.dart';
import 'package:send_man/viewmodels/progress_status_vm.dart';

class DownloadVm extends ChangeNotifier {
  final BuildContext context;
  DownloadVm(this.context);

  TextEditingController _urlController = TextEditingController();

  TextEditingController get urlController => _urlController;
  AdProvider get adProvider => Provider.of<AdProvider>(context, listen: false);
  ProgressStatusVM get progressStatus => Provider.of<ProgressStatusVM>(context);

  // download image
  Future downloadImage() async {
    final _progressStatusVm =
        Provider.of<ProgressStatusVM>(context, listen: false);
    final _isDone = _progressStatusVm.downloadStatus?.done ?? true;

    if (_isDone) {
      if (_urlController.text.trim() != '') {
        FocusScope.of(context).unfocus();

        final _coreImg = await ImgUploadProvider()
            .getSingleImageFromUrl(_urlController.text.trim());

        if (_coreImg != null && _coreImg.imgUrls != null) {
          _progressStatusVm.initializeDownloadStatus(
            ProgressStatus(
              title: 'Downloading...',
              total: _coreImg.imgUrls!.length,
              uploading: 1,
              done: false,
            ),
          );
          _urlController.clear();

          Fluttertoast.showToast(msg: 'Download started...');

          for (int i = 0; i < (_coreImg.imgUrls ?? []).length; i++) {
            final _imgUrl = _coreImg.imgUrls![i];
            await Future.delayed(Duration(milliseconds: 2000));
            _progressStatusVm.updateDownloadProgress(0.0);
            _progressStatusVm.updateDownloadedImgCount(i + 1);
            await ImgUploadProvider().downloadImage(_imgUrl);
            _progressStatusVm.updateDownloadProgress(1.0);
          }

          Fluttertoast.showToast(msg: 'Downloaded successfully');
          _progressStatusVm.completeDownload();
          adProvider.showInterstitialAd(forced: true);
        } else {
          Fluttertoast.showToast(msg: 'Image not found !');
        }
      }
    } else {
      FocusScope.of(context).unfocus();
      Fluttertoast.showToast(
        msg: 'Please wait for the previous images to be downloaded !',
      );
    }
  }
}
