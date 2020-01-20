
import 'package:device_info/device_info.dart';
import 'package:vocabulary_builder/v2/models/device/android.dart';

class PlatfromHelper {
  
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<Map<String, dynamic>> androidHandler() async {

    final AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
    return DeviceData(
      device: androidInfo.device,
      host: androidInfo.host,
      model: androidInfo.model,
      manufacturer: androidInfo.manufacturer,
      type: androidInfo.type,
      osVersion: androidInfo.version.sdkInt,
    ).toMap();
  }

  Future<Map<String, dynamic>> iosHandler() async {
    
    final IosDeviceInfo iosDeviceInfo = await _deviceInfo.iosInfo;
    return DeviceData(
      device: iosDeviceInfo.name,
      host: iosDeviceInfo.systemName,
      model: iosDeviceInfo.model,
      manufacturer: 'Apple',
      osVersion: iosDeviceInfo.systemVersion,
    ).toMap();
  }
}