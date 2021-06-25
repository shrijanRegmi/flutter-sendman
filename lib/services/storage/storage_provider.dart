import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageProvider {
  final File imgFile;
  final String path;
  final Function(double)? onProgressUpdate;
  StorageProvider({
    required this.imgFile,
    required this.path,
    this.onProgressUpdate,
  });

  // save file to firebase storage
  Future<String> uploadFile() async {
    var _downloadUrl = '';
    try {
      final _storage = FirebaseStorage.instance;
      final _ref = _storage.ref().child(path);
      final _uploadTask = _ref.putFile(imgFile);

      _uploadTask.snapshotEvents.listen((event) {
        var _progress =
            event.bytesTransferred.toDouble() / event.totalBytes.toDouble();

        print(_progress);

        if (onProgressUpdate != null) onProgressUpdate!(_progress);
      });

      await _uploadTask.whenComplete(() => print('Upload Complete'));

      _downloadUrl = await _ref.getDownloadURL();
    } catch (e) {
      print(e);
      print('Error!!!: Uploading image to firebase storage');
    }
    return _downloadUrl;
  }
}
