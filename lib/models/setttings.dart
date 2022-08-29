import 'dart:io';
import 'package:flutter/material.dart';

class ProjectSettings {
  String defaultCatalog = 'general-mammals';
}

get systemIcon {
  if (Platform.isAndroid) {
    return Icons.phone_android_rounded;
  } else if (Platform.isIOS) {
    return Icons.phone_iphone_rounded;
  } else if (Platform.isLinux) {
    return Icons.laptop_chromebook_rounded;
  } else if (Platform.isMacOS) {
    return Icons.laptop_mac_rounded;
  } else if (Platform.isWindows) {
    return Icons.laptop_windows_rounded;
  } else {
    return Icons.device_unknown_rounded;
  }
}
