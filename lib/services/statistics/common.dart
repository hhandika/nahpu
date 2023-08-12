class DataPoints {
  DataPoints({required this.labels, required this.data});

  final List<String> labels;
  final List<({int x, double y})> data;

  factory DataPoints.empty() {
    return DataPoints(labels: [], data: []);
  }

  factory DataPoints.fromData(Map<String, int> data) {
    List<String> labels = [];
    List<({int x, double y})> dataPoints = [];
    int index = 0;
    data.forEach((key, value) {
      labels.add(key);
      dataPoints.add((x: index, y: value.toDouble()));
      index++;
    });
    return DataPoints(labels: labels, data: dataPoints);
  }

  List<({int x, double y})> getMaxCount(int maxCount) {
    if (data.length > maxCount) {
      return data.sublist(0, maxCount);
    } else {
      return data;
    }
  }
}
