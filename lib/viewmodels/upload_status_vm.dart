import 'package:flutter/material.dart';
import 'package:send_man/models/upload_status_model.dart';

class UploadStatusVM extends ChangeNotifier {
  UploadStatus? _uploadStatus;
  UploadStatus? get uploadStatus => _uploadStatus;

  // initialize upload status
  initializeUploadStatus(final UploadStatus newStatus) {
    _uploadStatus = newStatus;
    notifyListeners();
  }

  // increase uploaded image count
  increaseUploadedImgCount(final int count) {
    _uploadStatus = _uploadStatus?.copyWith(
      uploaded: (_uploadStatus?.uploaded ?? 0) + count,
    );

    notifyListeners();
  }

  // complete upload
  completeUpload() {
    _uploadStatus = _uploadStatus?.copyWith(done: true);

    notifyListeners();
  }

  // update progress
  updateProgress(final double newProgress) {
    _uploadStatus = _uploadStatus?.copyWith(progress: newProgress);
    notifyListeners();
  }
}
