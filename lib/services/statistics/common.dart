class DataPoints {
  DataPoints({required this.labels, required this.data, required this.maxY});

  final List<String> labels;
  final List<({int x, double y})> data;
  final double maxY;

  factory DataPoints.empty() {
    return DataPoints(labels: [], data: [], maxY: 0);
  }

  factory DataPoints.fromData(Map<String, int> data) {
    List<String> labels = [];
    List<({int x, double y})> dataPoints = [];
    double maxY = data.entries.first.value.toDouble() + 2;
    int index = 0;
    data.forEach((key, value) {
      labels.add(key);
      dataPoints.add((x: index, y: value.toDouble()));
      index++;
    });
    return DataPoints(labels: labels, data: dataPoints, maxY: maxY);
  }

  List<({int x, double y})> getMaxCount(int maxCount) {
    if (data.length > maxCount) {
      return data.sublist(0, maxCount);
    } else {
      return data;
    }
  }
}
