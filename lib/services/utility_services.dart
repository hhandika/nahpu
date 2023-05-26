import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

String getSystemDateTime() {
  DateTime currentDate = DateTime.now();
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(currentDate);
}

String get listTileSeparator => " · ";

// Insert only unique values
List<String> getDistinctList(List<String?> list) {
  // Get unique value and remove empty string
  List<String> newList = list
      .toSet()
      .toList()
      .map((e) => e ?? '')
      .where((element) => element.isNotEmpty)
      .toList();

  return newList;
}

bool isListContains(List<String> list, String value) {
  return list.any((e) => e.toLowerCase() == value.toLowerCase());
}

extension StringExtension on String {
  bool isMatch(String value) {
    return toLowerCase() == value.toLowerCase();
  }
}
