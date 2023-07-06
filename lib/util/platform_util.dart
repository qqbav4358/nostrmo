import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class PlatformUtil {
  static BaseDeviceInfo? deviceInfo;

  static bool _isTable = false;

  static Future<void> init(BuildContext context) async {
    if (deviceInfo != null) {
      var deviceInfoPlus = DeviceInfoPlugin();
      deviceInfo = await deviceInfoPlus.deviceInfo;
    }

    var size = MediaQuery.of(context).size;
    if (Platform.isIOS) {
      print(deviceInfo.toString());
    } else {
      if (size.shortestSide > 600) {
        _isTable = true;
      }
    }

    // double ratio = size.width / size.height;
    // if ((ratio >= 0.74) && (ratio < 1.5)) {
    //   _isTable = true;
    // }
  }

  static bool isTableMode() {
    if (isPC()) {
      return true;
    }

    return _isTable;
  }

  static bool isPC() {
    return Platform.isWindows || Platform.isMacOS || Platform.isLinux;
  }
}
