class DataPoint {
  DataPoint(this.text, this.x, this.y);
  final String text;
  final double x;
  final double y;
}

List<DataPoint> createDataPoints(Map<String, int> countData) {
  if (countData.isEmpty) {
    return [];
  }

  List<DataPoint> dataPoints = [];
  int index = 0;
  countData.forEach((key, value) {
    dataPoints.add(DataPoint(key, index.toDouble(), value.toDouble()));
    index++;
  });
  return dataPoints;
}

List<DataPoint> getMaxCount(List<DataPoint> dataPoint, int maxCount) {
  if (dataPoint.length > maxCount) {
    return dataPoint.sublist(0, maxCount);
  } else {
    return dataPoint;
  }
}
