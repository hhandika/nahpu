import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nahpu/services/types/import.dart';

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

PlatformType get systemPlatform {
  if (Platform.isAndroid || Platform.isIOS) {
    return PlatformType.mobile;
  } else if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    return PlatformType.desktop;
  } else {
    return PlatformType.unknown;
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

extension StringMatching on String {
  bool isMatch(String value) {
    return toLowerCase() == value.toLowerCase();
  }
}

extension StringValidator on String {
  bool get isValidCollNum {
    final catNumRegex = RegExp(r'^[0-9]+$');
    return catNumRegex.hasMatch(this);
  }

  bool get isValidProjectName {
    final projectNameRegex =
        RegExp(r'^[\d\p{L}\p{Mn}\s\-\\_]+$', unicode: true);
    return projectNameRegex.hasMatch(this);
  }

  bool get isValidName {
    // Match name with unicode characters
    final nameRegex = RegExp(r'^[\p{L}\p{Mn}\p{Pd}\s\.\-]+$', unicode: true);
    return nameRegex.hasMatch(this);
  }

  bool get isValidInitial {
    final initialRegex = RegExp(r'^[a-zA-Z]+$');
    return initialRegex.hasMatch(this);
  }

  bool get isValidEmail {
    final emailRegex =
        RegExp(r'(^[a-zA-Z0-9_.]+[@]{1}[a-z0-9]+[\.][a-z](.)+$)');
    return emailRegex.hasMatch(this);
  }
}
