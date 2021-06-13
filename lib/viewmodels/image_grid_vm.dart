import 'package:flutter/material.dart';
import 'package:send_man/services/database/img_upload_provider.dart';

class ImgGridVm extends ChangeNotifier {
  // share image link
  Future<void> shareImage(final String id) async {
    await ImgUploadProvider().shareImage(id);
  }
}
