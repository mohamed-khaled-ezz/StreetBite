import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

import '../../domain/entities/device_details.dart';

class DeviceInfoDataSource {
  Future<DeviceDetails> load() async {
    final plugin = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      final info = await plugin.androidInfo;
      return DeviceDetails(
        brand: info.brand,
        model: info.model,
        osVersion: 'Android ${info.version.release}',
      );
    }
    if (Platform.isIOS) {
      final info = await plugin.iosInfo;
      return DeviceDetails(
        brand: 'Apple',
        model: info.utsname.machine,
        osVersion: 'iOS ${info.systemVersion}',
      );
    }
    return const DeviceDetails(brand: '-', model: '-', osVersion: '-');
  }
}
