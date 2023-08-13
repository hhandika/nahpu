import 'package:intl/intl.dart';

String get listTileSeparator => " · ";

int getCrossAxisCount(double screenWidth, int elementSize) {
  int crossAxisCount = 1;
  double safeWidth = screenWidth - 48;
  while (safeWidth > elementSize) {
    crossAxisCount++;
    safeWidth -= elementSize;
  }
  return crossAxisCount;
}

String getSystemDateTime() {
  DateTime currentDate = DateTime.now();
  return DateFormat('yyyy-MM-dd HH:mm:ss').format(currentDate);
}

({String date, String time}) parseDate(String? date) {
  if (date == null) return (date: '', time: '');

  DateTime? parsedDate = DateTime.tryParse(date);

  if (parsedDate == null) return (date: '', time: '');

  String formattedDate = DateFormat.yMMMMd().format(parsedDate);
  String formattedTime = DateFormat.jm().format(parsedDate);
  return (date: formattedDate, time: formattedTime);
}

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
  String toSentenceCase() {
    try {
      return '${this[0].toUpperCase()}${substring(1)}';
    } catch (e) {
      return '';
    }
  }
}

extension NullableStringExtension on String? {
  bool isContain(String value) {
    if (this == null || this!.isEmpty) {
      return false;
    }

    return this!.toLowerCase().contains(value.toLowerCase());
  }

  bool isMatch(String value) {
    if (this == null || this!.isEmpty) {
      return false;
    }
    return this!.toLowerCase() == value.toLowerCase();
  }

  bool isMatchExact(String value) {
    if (this == null || this!.isEmpty) {
      return false;
    }

    return this! == value;
  }
}

List<bool> checkListNumberContinuous(List<int> listNum) {
  List<bool> result = [];
  for (int i = 0; i < listNum.length - 1; i++) {
    if (listNum[i] + 1 == listNum[i + 1]) {
      result.add(true);
    } else {
      result.add(false);
    }
  }
  return result;
}

extension DoubleExtension on double {
  String truncateZero() {
    if (toString().endsWith('.0')) {
      // Remove trailing .0
      return toString().substring(0, toString().length - 2);
    } else {
      return toString();
    }
  }

  /// Truncate trailing zeros if exist in a decimal number.
  /// Otherwise, return the number as is.
  /// [fractionDigits] is the number of digits after the decimal point.
  String truncateZeroFixed(int fractionDigits) {
    if (toString().endsWith('.0')) {
      // Remove trailing .0
      return toStringAsFixed(fractionDigits)
          .substring(0, toString().length - 2);
    } else {
      return toStringAsFixed(fractionDigits);
    }
  }
}
