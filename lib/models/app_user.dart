import 'package:send_man/models/device_model.dart';

class AppUser {
  final String uid;
  final int? createdAt;
  final Device? device;

  AppUser({
    required this.uid,
    this.createdAt,
    this.device,
  });

  static AppUser fromJson(final Map<String, dynamic> data) {
    return AppUser(
      uid: data['uid'],
      createdAt: data['created_at'],
      device: data['device'] != null ? Device.fromJson(data['device']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'createdAt': createdAt,
      'device': device?.toJson(),
    };
  }
}
