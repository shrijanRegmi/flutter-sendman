import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:send_man/models/core_img_model.dart';
import 'package:send_man/models/upload_status_model.dart';
import 'package:send_man/services/database/img_upload_provider.dart';
import 'package:send_man/services/dialog/diaglog_provider.dart';
import 'package:send_man/viewmodels/upload_status_vm.dart';
import 'package:send_man/views/screens/upload_details_screen.dart';

class UploadVM extends ChangeNotifier {
  final BuildContext context;
  UploadVM(this.context);

  final _currentDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  File? _imgFile;
  List<File> _imgFiles = [];
  DateTime? _disDate;
  TimeOfDay? _disTime;

  List<CoreImage>? get coreImagesList => Provider.of<List<CoreImage>?>(context);
  List<CoreImage>? get todayImages => coreImagesList
      ?.where((element) => checkDate(
          DateTime.fromMillisecondsSinceEpoch(element.updatedAt ?? 0)))
      .toList();
  List<CoreImage>? get otherImages => coreImagesList
      ?.where((element) => !checkDate(
          DateTime.fromMillisecondsSinceEpoch(element.updatedAt ?? 0)))
      .toList();
  File? get imgFile => _imgFile;
  List<File> get imgFiles => _imgFiles;
  DateTime? get disDate => _disDate;
  TimeOfDay? get disTime => _disTime;

  // get initial image from gallery
  void getInitialImgFromGallery() async {
    final _pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      _imgFile = File(_pickedFile.path);
      notifyListeners();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UploadDetailScreen(initialImg: _imgFile!),
        ),
      );
    }
  }

  // upload additional images
  void uploadAdditionalImages() async {
    final _pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      final _mImg = File(_pickedFile.path);
      final _newImgs = _imgFiles;
      _newImgs.add(_mImg);
      updateImgFiles(_newImgs);
    }
  }

  // remove file
  void removeFile(final File removeImg) {
    final _newImgs = _imgFiles;
    _newImgs.remove(removeImg);

    updateImgFiles(_newImgs);
  }

  // check if given date is today or not
  bool checkDate(final DateTime date) {
    final _now = DateTime.now();

    return date.year == _now.year &&
        date.month == _now.month &&
        date.day == _now.day;
  }

  // open date picker
  void openDatePicker() async {
    final _pickedDate = await showDatePicker(
      context: context,
      initialDate: _currentDate,
      firstDate: _currentDate,
      lastDate: _currentDate.add(
        Duration(days: 7),
      ),
    );

    _disDate = _pickedDate;
    notifyListeners();
  }

  // open time picker
  void openTimePicker() async {
    final _pickedTime = await showTimePicker(
      context: context,
      initialTime: _disTime ?? TimeOfDay.now(),
    );

    _disTime = _pickedTime;
    notifyListeners();
  }

  // publish image
  void publishImages() async {
    final _androidInfo =
        Provider.of<AndroidDeviceInfo?>(context, listen: false);

    final _uploadStatusVm = Provider.of<UploadStatusVM>(context, listen: false);

    DialogProvider(context).showConfirmationDialog(
      'Are you sure you want to publish the images ?',
      'Updating the images or date/time is not possible in future, however you can delete or hide the images.',
      onPressedPositive: () async {
        Navigator.pop(context);

        _uploadStatusVm.initializeUploadStatus(
          UploadStatus(total: _imgFiles.length, uploaded: 0),
        );

        await ImgUploadProvider(
          uid: _androidInfo?.androidId ?? '',
        ).uploadCoreImg(
          _uploadStatusVm,
          _imgFiles,
          _disDate ?? _currentDate.add(Duration(days: 7)),
          _disTime ?? TimeOfDay.now(),
        );
      },
    );
  }

  // update value of _imgFiles
  void updateImgFiles(final List<File> newImgs) {
    _imgFiles = newImgs;

    notifyListeners();
  }
}
