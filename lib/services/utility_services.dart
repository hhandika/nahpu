import 'package:intl/intl.dart';

int getCrossAxisCount(double screenWidth, int elementSize) {
  int crossAxisCount = 1;
  double safeWidth = screenWidth - 24;
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
