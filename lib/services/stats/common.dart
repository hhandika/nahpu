class DataPoint {
  final double x;
  final double y;

  DataPoint(this.x, this.y);
}

List<DataPoint> createDataPoints(Map<String, int> countData, int maxCount) {
  List<DataPoint> dataPoints = [];
  int index = 0;
  countData.forEach((key, value) {
    dataPoints.add(DataPoint(index.toDouble(), value.toDouble()));
    index++;
  });
  // Sort the data points by y value
  dataPoints.sort((b, a) => a.y.compareTo(b.y));

  // If list >5 return top 5
  if (dataPoints.length > maxCount) {
    return dataPoints.sublist(0, maxCount);
  } else {
    return dataPoints;
  }
}
