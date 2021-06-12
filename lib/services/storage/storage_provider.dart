import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageProvider {
  final File imgFile;
  final String path;
  StorageProvider({
    required this.imgFile,
    required this.path,
  });

  // save file to firebase storage
  Future<String> uploadFile() async {
    var _downloadUrl = '';
    try {
      final _storage = FirebaseStorage.instance;
      final _ref = _storage.ref().child(path);
      final _uploadTask = _ref.putFile(imgFile);

      await _uploadTask.whenComplete(() => print('Upload Complete'));

      _downloadUrl = await _ref.getDownloadURL();
    } catch (e) {
      print(e);
      print('Error!!!: Uploading image to firebase storage');
    }
    return _downloadUrl;
  }
}
