import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:send_man/models/app_user.dart';
import 'package:send_man/models/device_model.dart';

class AppUserProvider {
  final _ref = FirebaseFirestore.instance;
  // send user to firestore
  Future sendUserToFirestore(final String uid) async {
    try {
      final _androidInfo = await DeviceInfoPlugin().androidInfo;

      final _device = Device(
        deviceName: _androidInfo.device,
        deviceModel: _androidInfo.model,
        osVersion: _androidInfo.version.baseOS ?? '',
      );
      final _appUser = AppUser(
        uid: uid,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        device: _device,
      );

      final _usersCol = _ref.collection('users').doc(uid);
      await _usersCol.set(_appUser.toJson());

      print("Success: Sending user to firestore");
      return 'Success';
    } catch (e) {
      print(e);
      print("Error!!!: Sending user to firestore");
    }
  }
}
