class AndroidDeviceData {

  final String device;
  final String host;
  final String manufacturer;

  final String model;
  final String type;
  final int sdk;

  AndroidDeviceData({
    this.device,
    this.host,
    this.manufacturer,
    this.model,
    this.type,
    this.sdk
  });

  Map<String, dynamic> toMap() => <String, dynamic> {
    'device': device,
    'host': host,
    'manufacturer': manufacturer,
    'model': model,
    'type': type,
    'sdk': sdk,
  };
}