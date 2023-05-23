import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:nahpu/services/stats/captures.dart';
import 'package:nahpu/services/types/statistics.dart';
import 'package:nahpu/services/types/types.dart';

class StatisticViewer extends ConsumerStatefulWidget {
  const StatisticViewer({Key? key}) : super(key: key);

  @override
  StatisticViewerState createState() => StatisticViewerState();
}

class StatisticViewerState extends ConsumerState<StatisticViewer> {
  GraphType selectedGraph = GraphType.speciesCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownButton<GraphType>(
                value: selectedGraph,
                items: graphOptions
                    .map((String value) => DropdownMenuItem<GraphType>(
                          value: GraphType.values[graphOptions.indexOf(value)],
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedGraph = value;
                    });
                  }
                },
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.fullscreen_outlined,
                  ))
            ],
          ),
        ),
        Expanded(
            child: GraphViewer(
          selectedGraph: selectedGraph,
        )),
      ],
    );
  }
}

class GraphViewer extends StatelessWidget {
  const GraphViewer({
    super.key,
    required this.selectedGraph,
  });

  final GraphType selectedGraph;

  @override
  Widget build(BuildContext context) {
    switch (selectedGraph) {
      case GraphType.speciesCount:
        return const SpeciesCountBarChart();
      default:
        return const Text('No graph selected');
    }
  }
}

class SpeciesCountBarChart extends ConsumerWidget {
  const SpeciesCountBarChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: BarChartViewer(
                title: 'Species Count',
                data: snapshot.data!.speciesCount,
                dataPoints: _createDataPoints(snapshot.data!.speciesCount),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
        future: _getStats(ref));
  }

  Future<CaptureRecordStats> _getStats(WidgetRef ref) async {
    CaptureRecordStats stats = CaptureRecordStats.empty();
    await stats.count(ref);
    return stats;
  }

  List<DataPoint> _createDataPoints(SplayTreeMap<String, int> speciesCount) {
    List<DataPoint> dataPoints = [];
    int index = 0;
    speciesCount.forEach((key, value) {
      dataPoints.add(DataPoint(index.toDouble(), value.toDouble()));
      index++;
    });

    // Sort the data points by y value
    dataPoints.sort((b, a) => a.y.compareTo(b.y));

    // If list >5 return top 5
    if (dataPoints.length > 5) {
      return dataPoints.sublist(0, 5);
    } else {
      return dataPoints;
    }
  }
}

class BarChartViewer extends StatelessWidget {
  const BarChartViewer({
    super.key,
    required this.data,
    required this.dataPoints,
    required this.title,
  });

  final SplayTreeMap<String, int> data;
  final List<DataPoint> dataPoints;
  final String title;

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
          alignment: BarChartAlignment.spaceAround,
          barGroups: dataPoints
              .map((e) => BarChartGroupData(x: e.x.toInt(), barRods: [
                    BarChartRodData(
                        toY: e.y,
                        color: Theme.of(context).colorScheme.secondaryContainer,
                        width: 25,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5))),
                  ]))
              .toList(),
          borderData: FlBorderData(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.tertiary,
                width: 3,
              ),
              left: BorderSide(
                color: Theme.of(context).colorScheme.tertiary,
                width: 3,
              ),
            ),
          ),
          gridData: FlGridData(show: true),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: _getTitleData(),
            ),
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: Theme.of(context).colorScheme.secondaryContainer,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                return BarTooltipItem(
                    rod.toY.truncateZero(),
                    TextStyle(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                    children: [
                      TextSpan(
                        text: '\n${data.keys.elementAt(group.x.toInt())}',
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]);
              },
            ),
          )),
    );
  }

  SideTitles _getTitleData() {
    return SideTitles(
      showTitles: true,
      interval: 5,
      getTitlesWidget: (value, meta) {
        return Text(
          _getFirstLetter(data.keys.elementAt(value.toInt())),
          overflow: TextOverflow.ellipsis,
        );
      },
    );
  }

  String _getFirstLetter(String value) {
    List<String> splitAtSpace = value.split(' ');
    if (splitAtSpace.length > 1) {
      String genus = splitAtSpace[0].substring(0, 1);
      String species = splitAtSpace[1].substring(0, 3);
      return '$genus. $species';
    } else {
      return value.substring(0, 1);
    }
  }
}

class SpeciesAccCurve extends ConsumerWidget {
  const SpeciesAccCurve({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
      child: LineChartViewer(
        title: 'Species Curve',
        dataPoints: [
          DataPoint(0, 3),
          DataPoint(1, 4),
          DataPoint(2, 5),
          DataPoint(3, 7),
          DataPoint(4, 4),
          DataPoint(5, 5),
        ],
      ),
    );
  }
}

class LineChartViewer extends StatelessWidget {
  const LineChartViewer(
      {super.key, required this.dataPoints, required this.title});

  final List<DataPoint> dataPoints;
  final String title;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots:
                dataPoints.map((e) => FlSpot(e.x, e.y)).toList(growable: true),
            isCurved: true,
            color: Theme.of(context).colorScheme.tertiary,
            barWidth: 2.5,
            isStrokeCapRound: false,
            dotData: FlDotData(
              show: false,
            ),
            // belowBarData: BarAreaData(
            //   show: true,
            //   color: const Color(0x00aa4cfc),
            // ),
          ),
        ],
        borderData: FlBorderData(
          border: Border(
            bottom: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
              width: 3,
            ),
            left: BorderSide(
              color: Theme.of(context).colorScheme.secondary,
              width: 3,
            ),
          ),
        ),
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(
          show: false,
        ),
      ),
    );
  }
}

class DataPoint {
  final double x;
  final double y;

  DataPoint(this.x, this.y);
}
