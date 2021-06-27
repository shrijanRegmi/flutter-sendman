import 'package:flutter/material.dart';
import 'package:send_man/enums/progress_status_type.dart';
import 'package:send_man/models/progress_status_model.dart';

class ProgressStatusVM extends ChangeNotifier {
  ProgressStatus? _uploadStatus;
  ProgressStatus? _downloadStatus;

  ProgressStatus? get uploadStatus => _uploadStatus;
  ProgressStatus? get downloadStatus => _downloadStatus;

  // get progress status by type
  ProgressStatus? getStatus(
    final ProgressStatusType type,
  ) {
    switch (type) {
      case ProgressStatusType.upload:
        return _uploadStatus;
      case ProgressStatusType.download:
        return _downloadStatus;
    }
  }

  // initialize upload status
  initializeUploadStatus(final ProgressStatus newStatus) {
    _uploadStatus = newStatus;
    notifyListeners();
  }

  // initialize download status
  initializeDownloadStatus(final ProgressStatus newStatus) {
    _downloadStatus = newStatus;
    notifyListeners();
  }

  // increase uploading image count
  updateUploadedImgCount(final int count) {
    _uploadStatus = _uploadStatus?.copyWith(
      uploading: count,
    );

    notifyListeners();
  }

  // increase downloaded image count
  updateDownloadedImgCount(final int count) {
    _downloadStatus = _downloadStatus?.copyWith(
      uploading: count,
    );

    notifyListeners();
  }

  // complete upload
  completeUpload() {
    _uploadStatus = _uploadStatus?.copyWith(done: true);

    notifyListeners();
  }

  // complete download
  completeDownload() {
    _downloadStatus = _downloadStatus?.copyWith(done: true);

    notifyListeners();
  }

  // update upload progress
  updateUploadProgress(final double newProgress) {
    _uploadStatus = _uploadStatus?.copyWith(progress: newProgress);
    notifyListeners();
  }

  // update download progress
  updateDownloadProgress(final double newProgress) {
    _downloadStatus = _downloadStatus?.copyWith(progress: newProgress);
    notifyListeners();
  }
}
