class DeviceData {

  final String device;
  final String host;
  final String manufacturer;

  final String model;
  final String type;
  final dynamic osVersion;

  DeviceData({
    this.device,
    this.host,
    this.manufacturer,
    this.model,
    this.type,
    this.osVersion
  });

  Map<String, dynamic> toMap() => <String, dynamic> {
    'device': device,
    'host': host,
    'manufacturer': manufacturer,
    'model': model,
    'type': type,
    'osVersion': osVersion,
  };
}