class Device {
  final String deviceName;
  final String deviceModel;
  final String osVersion;

  Device({
    this.deviceName = '',
    this.deviceModel = '',
    this.osVersion = '',
  });

  static Device fromJson(final Map<String, dynamic> data) {
    return Device(
      deviceName: data['device_name'],
      deviceModel: data['device_model'],
      osVersion: data['os_version'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'device_name': deviceName,
      'device_model': deviceModel,
      'os_version': osVersion,
    };
  }
}
